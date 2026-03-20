{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../common/boot-loader.nix
    ../../common/environment.nix
    ../../common/locale.nix
    ../../common/nix-settings.nix
    ./environment.nix
    ./framework.nix
    ./gui.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./programs.nix
    ./users.nix
    ./utilities.nix
  ];

  # Before changing this value read the documentation (https://nixos.org/nixos/options.html)
  system.stateVersion = "24.05";
}
