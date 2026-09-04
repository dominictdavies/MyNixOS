{ inputs, ... }:
{
  flake.nixosModules.zfs = {
    boot.zfs.enable = true;
    services.zfs.autoScrub.enable = true;
  };
}
