# NFS (https://wiki.nixos.org/wiki/NFS)
{ my, ... }:
{
  flake.nixosModules.nfs-server = {
    services.nfs = {
      server = {
        enable = true;

        # Share the pool with tailnet addresses only
        exports = ''
          ${my.storage.mountPoint} 100.64.0.0/10(rw,sync,no_subtree_check)
        '';
      };

      # NFSv4 only, so clients always negotiate the newest version without falling back to v3
      settings.nfsd.vers3 = false;
    };
  };

  flake.nixosModules.nfs-client = {
    boot.supportedFilesystems = [ "nfs" ];

    # Mount on first access rather than at boot, so booting never waits on the server
    fileSystems.${my.storage.mountPoint} = {
      device = "${my.hosts.server.name}:${my.storage.mountPoint}";
      fsType = "nfs";
      options = [
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=600"
      ];
    };
  };
}
