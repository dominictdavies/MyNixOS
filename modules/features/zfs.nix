{
  flake.nixosModules.zfs = {
    # TODO: Replace with output from `head -c4 /dev/urandom | od -A none -t x4`
    networking.hostId = "01234567";

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
