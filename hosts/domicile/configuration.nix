{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../common/boot-loader.nix
    ../../common/environment.nix
    ../../common/laptop-server.nix
    ../../common/locale.nix
    ../../common/nix-settings.nix
    ./boot-initrd.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./programs.nix
    ./users.nix
  ];

  # Before changing this value read the documentation (https://nixos.org/nixos/options.html)
  system.stateVersion = "24.05";
}
