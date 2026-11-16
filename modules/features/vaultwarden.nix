{
  flake.nixosModules.vaultwarden = { config, ... }: {
    services = {
      # Vaultwarden (https://wiki.nixos.org/wiki/Vaultwarden)
      vaultwarden = {
        enable = true;
        domain = "${config.networking.hostName}.${config.my.tailnet}";
        backupDir = "/mnt/terra/Backups/Vaultwarden";

        config = {
          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = 8222;

          # Set to true just long enough to create the first account
          SIGNUPS_ALLOWED = false;
        };
      };

      # HTTPS with a Tailscale certificate, reachable from the tailnet only
      caddy = {
        enable = true;

        virtualHosts.${config.services.vaultwarden.domain}.extraConfig = ''
          reverse_proxy 127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}
        '';
      };

      # Let Caddy fetch the certificate from Tailscale
      tailscale.permitCertUid = config.services.caddy.user;
    };

    # Only back up while terra is mounted, never onto the root disk
    systemd.services.backup-vaultwarden.unitConfig.RequiresMountsFor = "/mnt/terra";
  };
}
