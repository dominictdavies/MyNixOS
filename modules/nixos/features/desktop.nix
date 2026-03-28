{ self, inputs, ... }:
{
  flake.nixosModules.desktop =
    { ... }:
    {
      imports = [
        self.nixosModules.niri
      ];

      hardware = {
        enableAllFirmware = true;
        bluetooth.enable = true;
        opengl.enable = true;
      };
    };
}
