{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../common/boot-loader.nix
    ../../common/environment.nix
    ../../common/locale.nix
    ../../common/nix-settings.nix
    ./framework.nix
    ./gui.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./users.nix
    ./utilities.nix
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "dominictdavies" = import ./home.nix;
    };
  };

  # Before changing this value read the documentation (https://nixos.org/nixos/options.html)
  system.stateVersion = "24.05";
}
