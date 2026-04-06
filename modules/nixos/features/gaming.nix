{
  flake.nixosModules.gaming =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        steam
        prismlauncher
        gpu-screen-recorder
      ];

      programs = {
        steam = {
          enable = true;

          # Open ports in the firewall for Steam Remote Play
          remotePlay.openFirewall = true;

          # Open ports in the firewall for Source Dedicated Server
          dedicatedServer.openFirewall = true;

          # Open ports in the firewall for Steam Local Network Game Transfers
          localNetworkGameTransfers.openFirewall = true;
        };

        bash.shellAliases = {
          deltarune = "steam steam://rungameid/1671210 && exit";
        };
      };
    };
}
