{
  flake.nixosModules.common =
    { config, ... }:
    {
      services = {
        cockpit = {
          enable = true;
          allowed-origins = [ "https://${config.networking.hostName}:9090" ];
          settings.Session.IdleTimeout = 0;
        };
        fwupd.enable = true;
        tailscale = {
          enable = true;
          extraSetFlags = [
            "--operator=${config.my.username}"
            "--ssh=false"
          ];
        };
      };

      # Compressed swap in RAM (helps systemd-oomd under memory pressure)
      zramSwap.enable = true;
    };
}
