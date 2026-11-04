# MyNixOS

## Installation

1. `nixos-generate-config --show-hardware-config`
2. Adapt the output as `modules/hosts/<host>/hardware.nix` and push
3. `sudo env NIX_CONFIG="experimental-features = nix-command flakes" nixos-rebuild switch --flake github:dominictdavies/MyNixOS#<host>`
4. Reboot
5. `ssh-keygen` and add the public key to GitHub
6. `git clone git@github.com:dominictdavies/MyNixOS.git ~/MyNixOS`
7. `mynix-switch`
