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

# One password for both disk encryption and the user
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

# Partition, format, and mount at /mnt (disko's script, pointed at the chosen disk)
echo ">>> Partitioning $disk"
disko_script=$(nix "${nix_args[@]}" build --no-link --print-out-paths --impure \
    --argstr flake "git+file://$repo" --argstr host "$host" --argstr disk "$disk" \
    --expr '{ flake, host, disk }:
      let
        system = builtins.getAttr host (builtins.getFlake flake).nixosConfigurations;
        withDisk = system.extendModules {
          modules = [ { disko.devices.disk.main.device = system.pkgs.lib.mkForce disk; } ];
        };
      in
      withDisk.config.system.build.diskoScript')
"$disko_script" --yes-wipe-all-disks

# Build straight onto the new disk (not into the live USB's RAM), with nom showing progress
echo ">>> Building '$host'"
install_tmp=$(mktemp -d -p /mnt)
TMPDIR=$install_tmp nom build "${nix_args[@]}" "$repo#nixosConfigurations.$host.config.system.build.toplevel" \
    --eval-store auto --store /mnt --extra-substituters "auto?trusted=1" --out-link "$install_tmp/system"
system=$(readlink -f "$install_tmp/system")

echo ">>> Installing '$host'"
nixos-install --system "$system" --root /mnt --no-root-passwd --no-channel-copy
rm -rf "$install_tmp"

echo ">>> Setting password for $username"
printf '%s:%s\n' "$username" "$hash" |
    nixos-enter --root /mnt -c '/nix/var/nix/profiles/system/sw/bin/chpasswd -e'

# Repo in the user's home (owned by the first normal user, uid 1000)
mkdir -p "/mnt/home/$username"
cp -a "$repo" "/mnt/home/$username/MyNixOS"
chown -R 1000:100 "/mnt/home/$username/MyNixOS"

umount -R /mnt
echo ">>> Done! Reboot and remove the USB"
