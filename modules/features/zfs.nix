{ my, ... }:
{
  flake.nixosModules.zfs = {
    networking.hostId = "5d0be851";

    boot = {
      supportedFilesystems = [ "zfs" ];

      zfs = {
        extraPools = [ my.storage.pool ];
        forceImportRoot = false;
      };
    };

    services = {
      zfs.autoScrub.enable = true;

      # Snapshot every dataset in the pool, keeping a rolling history
      sanoid = {
        enable = true;

        datasets.${my.storage.pool} = {
          recursive = true;
          autosnap = true;
          autoprune = true;
          hourly = 24;
          daily = 30;
          monthly = 6;
        };
      };
    };
  };
}
