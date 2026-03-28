{ self, inputs, ... }:
{
  flake.nixosModules.desktop =
    { ... }:
    {
      imports = [
        self.nixosModules.bash
        self.nixosModules.niri
      ];

      hardware = {
        enableAllFirmware = true;
        bluetooth.enable = true;
      };
    };
}
