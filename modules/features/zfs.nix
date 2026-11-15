{
  flake.nixosModules.zfs = {
    networking.hostId = "5d0be851";

    boot = {
      supportedFilesystems = [ "zfs" ];

      zfs = {
        extraPools = [ "terra" ];
        forceImportRoot = false;
      };
    };

    services = {
      zfs.autoScrub.enable = true;

      # Snapshot every dataset in terra, keeping a rolling history
      sanoid = {
        enable = true;

        datasets.terra = {
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
