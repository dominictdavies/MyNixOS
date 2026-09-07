{
  flake.nixosModules.zfs =
    { pkgs, ... }:
    {
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
