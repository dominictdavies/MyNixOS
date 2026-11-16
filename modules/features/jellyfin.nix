{ my, ... }:
{
  flake.nixosModules.jellyfin = { config, ... }: {
    services = {
      # Jellyfin (https://wiki.nixos.org/wiki/Jellyfin)
      jellyfin = {
        enable = true;

        # Transcode with the integrated Radeon GPU
        hardwareAcceleration = {
          enable = true;
          type = "vaapi";
          device = "/dev/dri/renderD128";
        };
      };

      # HTTPS with a Tailscale certificate on Jellyfin's usual HTTPS port, reachable from the tailnet only
      caddy = {
        enable = true;

        virtualHosts."${config.networking.hostName}.${my.tailnet}:8920".extraConfig = ''
          reverse_proxy 127.0.0.1:8096
        '';
      };

      # Let Caddy fetch the certificate from Tailscale
      tailscale.permitCertUid = config.services.caddy.user;
    };

    # Only run while the pool is mounted, so a scan never finds the libraries empty
    systemd.services.jellyfin.unitConfig.RequiresMountsFor = my.storage.mountPoint;
  };
}
