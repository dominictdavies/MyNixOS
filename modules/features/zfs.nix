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

        # Fix external usb drive failure
        extraModprobeConfig = "options usb-storage quirks=0bda:9201:u,0bda:9210:u";
      };

      services.zfs.autoScrub.enable = true;
    };
}
