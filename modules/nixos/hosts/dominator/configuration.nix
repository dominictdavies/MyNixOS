{ self, ... }:
{
  flake.nixosModules.dominatorConfiguration =
    { pkgs, lib, ... }:
    {
      imports = with self.nixosModules; [
        common
        dominatorHardware
        desktop
        coding
        gaming
      ];

      hardware = {
        enableAllFirmware = true;
        bluetooth.enable = true;
      };

      networking.hostName = "dominator";

      # Do not modify! (https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion)
      system.stateVersion = "26.05";
    };
}
