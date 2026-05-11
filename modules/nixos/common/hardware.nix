{
  flake.nixosModules.common = {
    hardware = {
      enableAllFirmware = true;
      steam-hardware.enable = true;
    };
  };
}
