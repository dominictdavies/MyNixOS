#!/usr/bin/env bash
# Install one of the hosts in this repo onto the current machine, from a NixOS live USB.
#
# Usage: install <host>

set -euo pipefail

repo_url="https://github.com/dominictdavies/MyNixOS.git"

die() {
    echo "error: $*" >&2
    exit 1
}

[[ $# -eq 1 ]] || die "usage: install <host>"
[[ $EUID -eq 0 ]] || die "must be run as root (use sudo)"

host=$1
nix_args=(--extra-experimental-features "nix-command flakes")

password_file=/tmp/disko-password # Must match `passwordFile` in modules/common/disko.nix

workdir=$(mktemp -d)
trap 'rm -rf "$workdir" "$password_file"' EXIT

echo ">>> Cloning $repo_url"
repo=$workdir/MyNixOS
git clone --quiet "$repo_url" "$repo"

# Check the host exists and is set up for disko
if ! disks=$(nix "${nix_args[@]}" eval --raw "$repo#nixosConfigurations.$host.config.disko.devices.disk" \
    --apply 'd: builtins.concatStringsSep " " (builtins.attrNames d)' 2>/dev/null); then
    die "host '$host' does not exist"
fi
[[ $disks == "main" ]] || die "expected a single disko disk named 'main', found: $disks"
username=$(nix "${nix_args[@]}" eval --raw "$repo#nixosConfigurations.$host.config.my.username")

# Pick the disk to install to, skipping the live USB (anything mounted or containing an ISO filesystem)
# and compressed RAM swap
candidates=()
while read -r name; do
    if [[ $name == /dev/zram* ]] || lsblk -nrpo MOUNTPOINTS,FSTYPE "$name" | grep -qE '^/|iso9660'; then
        continue
    fi
    candidates+=("$(lsblk -dpno NAME,SIZE,MODEL "$name")")
done < <(lsblk -dpno NAME,TYPE | awk '$2 == "disk" { print $1 }')
[[ ${#candidates[@]} -gt 0 ]] || die "no disks found"

if [[ ${#candidates[@]} -eq 1 ]]; then
    choice=${candidates[0]}
else
    echo ">>> Select the disk to install '$host' to"
    PS3="Disk: "
    select choice in "${candidates[@]}"; do
        [[ -n $choice ]] && break
    done
fi
disk=${choice%% *}

echo
lsblk "$disk"
echo
read -rp "ALL DATA ON $disk WILL BE ERASED. Type the host name ($host) to continue: " confirm
[[ $confirm == "$host" ]] || die "aborted"

# One password for both disk encryption and the user (the user's is only applied on creation)
while true; do
    read -rsp "New password: " password
    echo
    read -rsp "Retype new password: " password2
    echo
    [[ -n $password && $password == "$password2" ]] && break
    echo "Passwords are empty or do not match, try again"
done
(umask 077 && printf '%s' "$password" >"$password_file")
hash=$(mkpasswd --method=yescrypt --stdin <<<"$password")
unset password password2
system_config=$(jq -cn --arg user "$username" --arg hash "$hash" \
    '{users: {users: {($user): {initialHashedPassword: $hash}}}}')

# Copy of the repo for the user's home on the new system (owned by the first normal user, uid 1000)
cp -a "$repo" "$workdir/home-repo"
chown -R 1000:100 "$workdir/home-repo"

# Partition, format, and install
echo ">>> Installing '$host' to $disk"
disko-install \
    --flake "$repo#$host" \
    --disk main "$disk" \
    --write-efi-boot-entries \
    --system-config "$system_config" \
    --extra-files "$workdir/home-repo" "/home/$username/MyNixOS"

echo ">>> Done! Reboot and remove the USB"
