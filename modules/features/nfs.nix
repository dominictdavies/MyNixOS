# NFS (https://wiki.nixos.org/wiki/NFS)
{
  flake.nixosModules.nfs-server = {
    services.nfs = {
      server = {
        enable = true;

        # Share terra with tailnet addresses only
        exports = ''
          /mnt/terra 100.64.0.0/10(rw,sync,no_subtree_check)
        '';
      };

      # NFSv4 only, so clients always negotiate the newest version without falling back to v3
      settings.nfsd.vers3 = false;
    };
  };

  flake.nixosModules.nfs-client = {
    boot.supportedFilesystems = [ "nfs" ];

    # Mount on first access rather than at boot, so booting never waits on domicile
    fileSystems."/mnt/terra" = {
      device = "domicile:/mnt/terra";
      fsType = "nfs";
      options = [
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=600"
      ];
    };
  };
}
