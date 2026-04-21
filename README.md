# MyNixOS

## Installation

### Switch Flake

`sudo nixos-rebuild switch --flake ~/MyNixOS#dominXXX`

`mynix-switch`

### Generate Keys

`ssh-keygen`

### VSCode Runtime Arguments

```json
// Use GNOME keyring
"password-store": "gnome-libsecret"
```

## Known Issues

- Screen remains off after resuming from suspend (on Dominator)
- Occasionally workspace icons will duplicate on switching monitor focus
- X11 apps do not use the correct cursor theme
- VSCode requires manually specifying keyring
