{ inputs, ... }:
{
  flake.nixosModules.zfs = {
    services.zfs.autoScrub.enable = true;
  };
}
