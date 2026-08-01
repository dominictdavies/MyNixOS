{
  flake.nixosModules.common = {
    hardware.enableRedistributableFirmware = true;
  };
}
