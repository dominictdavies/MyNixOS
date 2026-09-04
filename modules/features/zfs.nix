{
  flake.nixosModules.zfs = {
    environment.systemPackages = with pkgs; [
      zfs
    ];

    services.zfs.autoScrub.enable = true;
  };
}
