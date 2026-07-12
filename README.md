# MyNixOS

## Installation

### Switch Flake

`sudo nixos-rebuild switch --flake ~/MyNixOS#dominXXX`

`mynix-switch`

### Generate Keys

`ssh-keygen`

### Windows Machine

`mkdir ~/Machines && cd ~/Machines`

`quickget windows 11`

- Follow instructions to resolve download

`nix-shell -p wget --run "wget -O ~/Machines/windows-11/virtio-win.iso https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso"`

### VSCode Runtime Arguments

```json
// Use GNOME keyring
"password-store": "gnome-libsecret"
```

## Known Issues

- Screen remains off after resuming from suspend (on Dominator)
- Occasionally workspace icons will duplicate on switching monitor focus
- VSCode requires manually specifying keyring
