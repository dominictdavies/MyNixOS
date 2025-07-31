{ config, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts."dominictdavies.dev" = {
      forceSSL = true;  # Redirects HTTP to HTTPS
      sslCertificate = "/var/lib/acme/dominictdavies.dev/fullchain.pem";
      sslCertificateKey = "/var/lib/acme/dominictdavies.dev/key.pem";
      locations = {
        "/" = {
          # Proxy to Grafana
          proxyPass = "http://localhost:${toString config.services.grafana.settings.server.http_port}";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Host $host;
          '';
        };
      };
    };
  };

  # Let's Encrypt
  security.acme = {
    acceptTerms = true;
    defaults.email = "dominictdavies@gmail.com";
    certs."dominictdavies.dev" = {
      dnsProvider = "cloudflare";
      credentialsFile = "/etc/nixos/cf-creds.env";
    };
  };

  # Grant Nginx access to ACME certs
  systemd.services.nginx.serviceConfig.SupplementaryGroups = [ "acme" ];
}
