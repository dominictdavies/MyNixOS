{
  flake.nixosModules.zfs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        zfs
      ];

      services.zfs.autoScrub.enable = true;
    };
}
