# MyNixOS

## Installation

1. Boot a NixOS live USB and connect to the internet
2. `sudo nix --extra-experimental-features "nix-command flakes" run github:dominictdavies/MyNixOS#install -- <host>`
3. Reboot and remove the live USB
4. Check hardware from `nixos-generate-config --show-hardware-config` is covered by configuration
5. Run `ssh-keygen` and add the public key to GitHub
6. `git -C ~/MyNixOS remote set-url origin git@github.com:dominictdavies/MyNixOS.git`
