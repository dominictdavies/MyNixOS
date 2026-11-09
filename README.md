# MyNixOS

## Installation

1. Boot a NixOS live USB and connect to the internet
2. Check that the hardware from `nixos-generate-config --show-hardware-config` is covered by your selected host
3. `sudo nix --extra-experimental-features "nix-command flakes" run --refresh github:dominictdavies/MyNixOS#install -- <host>`
4. Reboot and remove the live USB

### Keys

1. Run `ssh-keygen` and add the public key to GitHub
2. `git -C ~/MyNixOS remote set-url origin git@github.com:dominictdavies/MyNixOS.git`

### Fingerprint

1. `sudo fprint-enroll`
2. `sudo fprint-verify`

### Cursor

1. `lxappearance`
2. Select the "Mouse Cursor" heading
3. Install a cursor from `~/MyNixOS/assets/cursor`
4. Apply the cursor and reboot
