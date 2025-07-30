{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ../../common/boot-loader.nix
      ../../common/environment.nix
      ../../common/locale.nix
      ../../common/nix-settings.nix
      ../../common/server-networking.nix
      ./hardware-configuration.nix
      ./overlays.nix
      ./nginx.nix
      ./minecraft-servers.nix
      ./tmodloader-servers.nix
      ./valheim-server.nix
      ./backups.nix
      inputs.home-manager.nixosModules.default
    ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "dominictdavies" = import ./home.nix;
    };
  };

  # Networking
  networking.hostName = "dominion";
  networking.defaultGateway = "10.1.1.1";

  # Static IP
  networking.interfaces.eth0.ipv4.addresses = [ {
    address = "10.1.1.202";
    prefixLength = 24;
  } ];

  # Define a user account
  users.users.dominictdavies = {
    isNormalUser = true;
    description = "Dominic Davies";
    extraGroups = [ "networkmanager" "wheel" ];
    # hashedPassword = "*";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMbpqoIuCOeH2FjQmCdiqWsHAwKarHLW3JUIZMKsWLLB dominictdavies@gmail.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYWWLuj8iaTVE/2TQbXhosNCzQcRB+RhMvnPHcXfgxrH4XqpF0we5xF1tC94zFDzzn3VwYkQpL2kKSdtSVNCyGfywPIOZpSQc5zuiNfc50uajN+XBkECYdVgdiJLRPOwCIECyTllSyJUmA+KKjjNzKOGLCmBCkVhZ6XiJ1+ErxUzYy5PXYZip3N2OiIgS3nACtqpHe2Jo9bvP6kZi9QxpWa87C0M7zW65uHKDYusJxKlYe2fKBF6jfHniMN0ZuQvWaoZ3y4lGp5mlQf2QtUdNgm9197LpHsSWVAidbxVTa+2yDNpJv33rnOcAmhpSrfOrGNzOaqmObkCde8HCTsopg9YFT3ixmDRjMltd/+YfY+j/3BT331lRIBD1uDysQYb6+84LVdq9HnEQ6DzX69C2ZmX1koE9pCTq84KGzK6WReE6rf4AK0JXmnE23dTRV4GDnNIPW/y4nl+8XWRS6kusvVtACd6/shU48YjQke5Yxuf2JDMvUb2LMPUZQvRo4zgMd5Vmen9eutK599GrPbZsKh7Rm9jnSR+xHr7s7umYbPmTSe14t5Ka73uf80nj0SFRersKDxzZbPlIN9eUy8g6SajTXzGKiWdOBMP5hSCLpyOd26toWl3NW7hUrPrg4XTJbxxNKG33glYkrS6SAZF7mXrr3PLYavk/iwxPyVs8NOQ== dominictdavies@dominator"
    ];
    packages = with pkgs; [];
  };

  # Open ports in the firewall
  networking.firewall.allowedTCPPorts = [ 443 25565 ];
  networking.firewall.allowedUDPPorts = [ 2456 2457 25565 ];

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

  # Grafana & Prometheus
  services = {
    grafana = {
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

    prometheus = {
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
  };

  # Before changing this value read the documentation (https://nixos.org/nixos/options.html)
  system.stateVersion = "24.05";
}
