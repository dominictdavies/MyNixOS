{
  flake.nixosModules.zfs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        zfs
      ];

      networking.hostId = "01234567";
      boot.supportedFilesystems = [ "zfs" ];
      boot.zfs.forceImportRoot = false;
      services.zfs.autoScrub.enable = true;
    };
}
