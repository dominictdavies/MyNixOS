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
}
