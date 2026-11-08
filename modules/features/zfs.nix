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

    services.zfs.autoScrub.enable = true;
  };
}
