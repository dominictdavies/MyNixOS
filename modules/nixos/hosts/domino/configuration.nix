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
        desktop

        # Development
        coding
        docker
        vagrant

        # Extras
        printing
        compatibility
        fileSharing
        gaming
      ];

      hardware = {
        enableAllFirmware = true;
        bluetooth.enable = true;
      };

      networking.hostName = "domino";

      # Do not modify! (https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion)
      system.stateVersion = "26.05";
    };
}
