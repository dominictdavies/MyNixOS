{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../common/boot-loader.nix
    ../../common/environment.nix
    ../../common/laptop-server.nix
    ../../common/locale.nix
    ../../common/nix-settings.nix
    ./backups.nix
    ./grafana-and-prometheus.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./nginx.nix
    ./overlays.nix
    ./users.nix
    ./servers/minecraft.nix
    ./servers/tmodloader.nix
    ./servers/valheim.nix
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
