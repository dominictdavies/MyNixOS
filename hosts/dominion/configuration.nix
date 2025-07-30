{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../common/boot-loader.nix
    ../../common/environment.nix
    ../../common/laptop-server.nix
    ../../common/locale.nix
    ../../common/nix-settings.nix
    ./hardware-configuration.nix
    ./overlays.nix
    ./users.nix
    ./networking.nix
    ./nginx.nix
    ./grafana-and-prometheus.nix
    ./server-minecraft.nix
    ./server-tmodloader.nix
    ./server-valheim.nix
    ./backups.nix
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
