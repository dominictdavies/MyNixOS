# MyNixOS

Follow [Preparation](#preparation), then [Installation](#installation) on domicile, dominator, and dominion, then every host section below in order.

## Preparation

1. Create a Tailscale account
2. In the Tailscale admin console's DNS settings, enable MagicDNS and HTTPS Certificates

## Installation

1. Boot a NixOS live USB and connect to the internet
2. Check that the hardware from `nixos-generate-config --show-hardware-config` is covered by your selected host, including its Ethernet driver (`readlink /sys/class/net/en*/device/driver`) in `modules/common/remote-unlock.nix`
3. `sudo nix --extra-experimental-features "nix-command flakes" run --refresh github:dominictdavies/MyNixOS#install -- <host>`
4. Reboot and remove the live USB

### Keys

1. `ssh-keygen`
2. Add the public key to GitHub and `modules/common/users.nix`
3. `git -C ~/MyNixOS remote set-url origin git@github.com:dominictdavies/MyNixOS.git`
4. Commit, push, and run `mynix-pull-switch` on the other hosts

### Tailscale

1. Remove any old machine with the host's name from the Tailscale admin console
2. `tailscale up`
3. `tailscale status`
4. Disable key expiry for the host in the Tailscale admin console
5. Update the host's IP in `networking.hosts` in `modules/features/domino.nix`
6. Set `my.tailnet` in `modules/common/options.nix` to the tailnet DNS name (`<tailnet>` below) if it differs
7. Commit and push

## Domicile

### ZFS

1. `lsblk -d -o NAME,SIZE,TRAN,MODEL,SERIAL` and `ls -l /dev/disk/by-id/` to match the four drives to their `/dev/disk/by-id/` paths
2. `sudo zpool create -o ashift=12 -o autoexpand=on terra raidz1 <drives>`
3. `sudo zfs create -o mountpoint=/mnt/terra -o compression=lz4 -o atime=off terra/data`
4. `sudo chown dominictdavies:users /mnt/terra`
5. `mkdir /mnt/terra/Backups`
6. Reboot

### WebDAV

1. `sudo install -D -m 600 /dev/null /etc/secrets/webdav.env`
2. Add `WEBDAV_USERNAME` and `WEBDAV_PASSWORD` to `/etc/secrets/webdav.env`
3. `mkdir -p /mnt/terra/Backups/Super-Productivity`
4. `sudo systemctl restart webdav`

### Vaultwarden

1. Temporarily set `SIGNUPS_ALLOWED = true` in `modules/features/vaultwarden.nix` and rebuild
2. Create an account at `https://domicile.<tailnet>`
3. Set `SIGNUPS_ALLOWED = false` and rebuild
4. Add the WebDAV login from step 2 of [WebDAV](#webdav)

To restore from a backup instead:

1. `sudo systemctl stop vaultwarden`
2. `sudo cp -a /mnt/terra/Backups/Vaultwarden/. /var/lib/vaultwarden/`
3. `sudo chown -R vaultwarden:vaultwarden /var/lib/vaultwarden`
4. `sudo systemctl start vaultwarden`

## Dominator

### Bitwarden Extension

1. Install the Bitwarden extension in Firefox
2. Select "self-hosted" and log in with `https://domicile.<tailnet>`

### Super Productivity

1. In Settings -> Sync, select WebDAV
2. Use the base URL `https://domicile.<tailnet>/super-productivity` and the WebDAV login from [Vaultwarden](#vaultwarden)

### Cursor

1. `lxappearance`
2. Select the "Mouse Cursor" heading
3. Install a cursor from `~/MyNixOS/assets/cursor`
4. Apply the cursor and reboot

## Dominion

### Desktop

1. Follow every section of [Dominator](#dominator)

### Fingerprint

1. `sudo fprint-enroll`
2. `sudo fprint-verify`

## Domino

### Nix-on-Droid

1. Install the Nix-on-Droid app and complete its first-time setup with flakes enabled
2. `nix-on-droid switch --flake github:dominictdavies/MyNixOS#domino --refresh`
3. Restart the app
4. `git clone https://github.com/dominictdavies/MyNixOS.git ~/MyNixOS`
5. Follow every step of [Keys](#keys)

### Tailscale App

1. Install the Tailscale app and log in
2. Follow steps 1, 4, 5, and 7 of [Tailscale](#tailscale)
3. Repeat step 2 of [Nix-on-Droid](#nix-on-droid)

### Aegis

1. Install the Aegis app
2. Enable automatic backups to `Backups/Aegis`
3. Enable two-step login for Vaultwarden

### Syncthing

1. Install the Syncthing-Fork app
2. Set `devices.domino.id` in `modules/features/syncthing.nix` to the app's device ID
3. Commit, push, and run `mynix-pull-switch` on domicile
4. Run `syncthing device-id --home ~/.config/syncthing` on domicile, and add domicile as a device with that ID and the address `tcp://domicile.<tailnet>:22000`
5. Add a "Send Only" folder with the ID `aegis` for `Backups/Aegis`, shared with domicile

### Bitwarden App

1. Install the Bitwarden app
2. Follow step 2 of [Bitwarden Extension](#bitwarden-extension)

### Super Productivity App

1. Install the Super Productivity app
2. Follow every step of [Super Productivity](#super-productivity)
