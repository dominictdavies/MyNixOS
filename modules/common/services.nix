{
  flake.nixosModules.common = {
    services.fwupd.enable = true;
  };
}
