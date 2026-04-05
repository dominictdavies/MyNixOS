{ self, ... }:
{
  flake.nixosModules.dominoConfiguration =
    { pkgs, lib, ... }:
    {
      imports = with self.nixosModules; [
        common
        dominoHardware
        desktop
        coding
        docker
        vagrant
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
