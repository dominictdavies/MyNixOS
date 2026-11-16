# MyNixOS

Follow [Preparation](#preparation), then [Installation](#installation) on the server, computer, and laptop, then every host section below in order.

Values in angle brackets come from `my` in `modules/options.nix`, e.g. `<server>` is `my.hosts.server.name` and `<backups>` is `my.storage.backups`.

## Preparation

1. Create a Tailscale account
2. In the Tailscale admin console's DNS settings, enable MagicDNS and HTTPS Certificates

## Installation

1. Boot a NixOS live USB and connect to the internet
2. Check that the hardware from `nixos-generate-config --show-hardware-config` is covered by your selected host, including its Ethernet driver (`readlink /sys/class/net/en*/device/driver`) in `modules/common/remote-unlock.nix`
3. `sudo nix --extra-experimental-features "nix-command flakes" run --refresh github:<repo>#install -- <host>`
4. Reboot and remove the live USB

### Keys

1. `ssh-keygen`
2. Add the public key to GitHub and `my.sshKeys`
3. `git -C <repoRoot> remote set-url origin git@github.com:<repo>.git`
4. Commit, push, and run `mynix-pull-switch` on the other hosts

### Tailscale

1. Remove any old machine with the host's name from the Tailscale admin console
2. `tailscale up`
3. `tailscale status`
4. Disable key expiry for the host in the Tailscale admin console
5. Update the host's `tailscaleIp` in `my.hosts`
6. Set `my.tailnet` to the tailnet DNS name (`<tailnet>`) if it differs
7. Commit and push

## Server

### ZFS

1. `lsblk -d -o NAME,SIZE,TRAN,MODEL,SERIAL` and `ls -l /dev/disk/by-id/` to match the four drives to their `/dev/disk/by-id/` paths
2. `sudo zpool create -o ashift=12 -o autoexpand=on <pool> raidz1 <drives>`
3. `sudo zfs create -o mountpoint=<mountPoint> -o compression=lz4 -o atime=off <pool>/data`
4. `sudo chown <username>:users <mountPoint>`
5. `mkdir <backups>`
6. Reboot

### WebDAV

1. `sudo install -D -m 600 /dev/null /etc/secrets/webdav.env`
2. Add `WEBDAV_USERNAME` and `WEBDAV_PASSWORD` to `/etc/secrets/webdav.env`
3. `mkdir -p <backups>/Super-Productivity`
4. `sudo systemctl restart webdav`

### Vaultwarden

1. Temporarily set `SIGNUPS_ALLOWED = true` in `modules/features/vaultwarden.nix` and rebuild
2. Create an account at `https://<server>.<tailnet>`
3. Set `SIGNUPS_ALLOWED = false` and rebuild
4. Add the WebDAV login from step 2 of [WebDAV](#webdav)

To restore from a backup instead:

1. `sudo systemctl stop vaultwarden`
2. `sudo cp -a <backups>/Vaultwarden/. /var/lib/vaultwarden/`
3. `sudo chown -R vaultwarden:vaultwarden /var/lib/vaultwarden`
4. `sudo systemctl start vaultwarden`

## Computer

### Bitwarden Extension

1. Install the Bitwarden extension in Firefox
2. Select "self-hosted" and log in with `https://<server>.<tailnet>`

### Super Productivity

1. In Settings -> Sync, select WebDAV
2. Use the base URL `https://<server>.<tailnet>/super-productivity` and the WebDAV login from [Vaultwarden](#vaultwarden)

### Cursor

1. `lxappearance`
2. Select the "Mouse Cursor" heading
3. Install a cursor from `<repoRoot>/assets/cursor`
4. Apply the cursor and reboot

## Laptop

### Desktop

1. Follow every section of [Computer](#computer)

### Fingerprint

1. `sudo fprint-enroll`
2. `sudo fprint-verify`

## Phone

### Nix-on-Droid

1. Install the Nix-on-Droid app and complete its first-time setup with flakes enabled
2. `nix-on-droid switch --flake github:<repo>#<phone> --refresh`
3. Restart the app
4. `git clone https://github.com/<repo>.git <repoRoot>`
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
2. Set `my.hosts.phone.syncthingId` to the app's device ID
3. Commit, push, and run `mynix-pull-switch` on the server
4. Run `syncthing device-id --home ~/.config/syncthing` on the server, and add it as a device with that ID and the address `tcp://<server>.<tailnet>:22000`
5. Add a "Send Only" folder with the ID `aegis` for `Backups/Aegis`, shared with the server

### Bitwarden App

1. Install the Bitwarden app
2. Follow step 2 of [Bitwarden Extension](#bitwarden-extension)

### Super Productivity App

1. Install the Super Productivity app
2. Follow every step of [Super Productivity](#super-productivity)
