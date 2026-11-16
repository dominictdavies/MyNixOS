{ my, ... }:
{
  flake.nixosModules.webdav = { config, ... }: {
    services = {
      # Sync target for Super Productivity (https://github.com/hacdias/webdav)
      webdav = {
        enable = true;
        user = my.username;
        group = "users";

        # Holds WEBDAV_USERNAME and WEBDAV_PASSWORD, kept out of the Nix store
        environmentFile = "/etc/secrets/webdav.env";

        settings = {
          address = "127.0.0.1";
          port = 8223;
          prefix = "/super-productivity";
          behindProxy = true;
          directory = "${my.storage.backups}/Super-Productivity";
          permissions = "CRUD";

          users = [
            {
              username = "{env}WEBDAV_USERNAME";
              password = "{env}WEBDAV_PASSWORD";
            }
          ];
        };
      };

      # HTTPS with a Tailscale certificate, reachable from the tailnet only
      caddy = {
        enable = true;

        virtualHosts."${config.networking.hostName}.${my.tailnet}".extraConfig = ''
          @webdav path ${config.services.webdav.settings.prefix} ${config.services.webdav.settings.prefix}/*

          handle @webdav {
            reverse_proxy 127.0.0.1:${toString config.services.webdav.settings.port}
          }
        '';
      };

      # Let Caddy fetch the certificate from Tailscale
      tailscale.permitCertUid = config.services.caddy.user;
    };

    # Only serve while the pool is mounted, never from the root disk
    systemd.services.webdav.unitConfig.RequiresMountsFor = my.storage.mountPoint;
  };
}
