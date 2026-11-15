{
  flake.nixosModules.syncthing = { config, ... }: {
    # Syncthing (https://wiki.nixos.org/wiki/Syncthing)
    services.syncthing = {
      enable = true;
      user = config.my.username;
      group = "users";
      dataDir = "/home/${config.my.username}";
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

        devices.domino.id = "XMBWKYF-ARGGKN7-NGCJP2I-P7JS4NA-G2LNKQ2-CY5RCFK-QIZSGVK-YXLGSA6";

        folders.aegis = {
          path = "/mnt/terra/Backups/Aegis";
          devices = [ "domino" ];
          type = "receiveonly";
        };
      };
    };

    # Only sync while terra is mounted, never onto the root disk
    systemd.services.syncthing.unitConfig.RequiresMountsFor = "/mnt/terra";
  };
}
