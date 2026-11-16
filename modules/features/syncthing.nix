{ my, ... }:
{
  flake.nixosModules.syncthing = {
    # Syncthing (https://wiki.nixos.org/wiki/Syncthing)
    services.syncthing = {
      enable = true;
      user = my.username;
      group = "users";
      dataDir = my.home;
      overrideDevices = true;
      overrideFolders = true;

      settings = {
        # Tailnet only, so no relays, discovery servers, or usage reporting
        options = {
          globalAnnounceEnabled = false;
          localAnnounceEnabled = false;
          relaysEnabled = false;
          urAccepted = -1;
        };

        devices.${my.hosts.phone.name}.id = my.hosts.phone.syncthingId;

        folders.aegis = {
          path = "${my.storage.backups}/Aegis";
          devices = [ my.hosts.phone.name ];
          type = "receiveonly";
        };
      };
    };

    # Only sync while the pool is mounted, never onto the root disk
    systemd.services.syncthing.unitConfig.RequiresMountsFor = my.storage.mountPoint;
  };
}
