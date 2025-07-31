{ config, ... }:

{
  services.grafana = {
    enable = true;
    settings.server.http_addr = "0.0.0.0";
    settings.server.http_port = 3000;
    provision = {
      enable = true;
      datasources.settings.datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          access = "proxy";
          url = "http://localhost:${toString config.services.prometheus.port}";
        }
      ];
    }; 
  };

  services.prometheus = {
    enable = true;
    listenAddress = "localhost";
    port = 9090;

    exporters.node = {
      enable = true;
      listenAddress = "localhost";
      port = 9100;
    };

    scrapeConfigs = [
      {
        job_name = "Node";
        scrape_interval = "10s";
        static_configs = [
          { targets = [ "localhost:${toString config.services.prometheus.exporters.node.port}" ]; }
        ];
      }
    ];
  };
}
