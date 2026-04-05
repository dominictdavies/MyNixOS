{ self, ... }:
{
  flake.nixosModules.dominoConfiguration =
    { pkgs, lib, ... }:
    {
      imports = with self.nixosModules; [
        common

        # Hardware
        dominoHardware
        framework

        # Interface
        bash
        desktop

        # Development
        coding
        docker
        vagrant

        # Extras
        lanFileSharing
        compatibility
        gaming
      ];

      hardware = {
        enableAllFirmware = true;
        bluetooth.enable = true;
      };

      services = {
        fwupd.enable = true;
        printing.enable = true;
      };

      networking = {
        hostName = "domino";
        networkmanager.enable = true;
      };

      # See `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
      system.stateVersion = "26.05"; # Did you read the comment?
    };
}
