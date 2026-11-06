# MyNixOS

## Installation

1. Boot a NixOS live USB and connect to the internet
2. `sudo nix --extra-experimental-features "nix-command flakes" run github:dominictdavies/MyNixOS#install -- <host>`
3. Reboot
4. `ssh-keygen` and add the public key to GitHub
5. `git -C ~/MyNixOS remote set-url origin git@github.com:dominictdavies/MyNixOS.git`
