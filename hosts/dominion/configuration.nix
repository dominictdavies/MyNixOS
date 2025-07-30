{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ../../common/boot-loader.nix
      ../../common/environment.nix
      ../../common/locale.nix
      ../../common/nix-settings.nix
      ./hardware-configuration.nix
      ./minecraft-servers.nix
      inputs.home-manager.nixosModules.default
      inputs.nix-tmodloader.nixosModules.tmodloader
    ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "dominictdavies" = import ./home.nix;
    };
  };

  # Overlays
  nixpkgs.overlays = [ 
    inputs.nix-minecraft.overlay 
    inputs.nix-tmodloader.overlay
  ];

  # Networking
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;
  networking.hostName = "dominion";
  networking.defaultGateway = "10.1.1.1";
  networking.nameservers = [ "8.8.8.8" ];

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

  # Prevent laptop from sleeping on lid close
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  # Enable the OpenSSH daemon
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;

  # Open ports in the firewall
  networking.firewall.allowedTCPPorts = [ 443 25565 ];
  networking.firewall.allowedUDPPorts = [ 2456 2457 25565 ];

  # Nginx
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

  # tModLoader server
  services.tmodloader = {
    enable = true;
    servers = {
      third_calamity = {
        enable = true;
        openFirewall = true;
        noupnp = true;
        players = 6;
        world = "/var/lib/tmodloader/third_calamity/Worlds/Winners_Only.wld";
        password = "afflicted wind parmesan";
        install = [
          2824688072 # Calamity Mod
          2824688266 # Calamity Mod Music
          2687866031 # Census - Town NPC Checklist
          2599842771 # AlchemistNPC Lite
          2565540604 # Auto Trash
          2838188064 # Basic Automated (Vein) Mining
          2818817085 # Better Respawn
          2669644269 # Boss Checklist
          2816694149 # Boss Cursor
          3241967932 # Calamity: Hunt of the Old God
          2824688804 # Calamity's Vanities
          2838015851 # Catalyst Mod
          2835214226 # Calamity Mod Extra Music
          2570931073 # Fargo's Mutant Mod
          3222493606 # Luminance
          2815540735 # Fargo's Souls Mod
          2785100219 # Subworld Library
          3044249615 # Calamity - Fargo's Souls DLC
          2782337219 # Fargo's Music Mod
          2670628346 # Lights And Shadows
          2908170107 # absoluteAquarian Utilities (SerousCommonLib)
          2563309347 # Magic Storage
          2562915378 # Max Stack Plus Extra
          2831752947 # LuiAFK Reborn
          2812377597 # No Pylon Restrictions
          3172916251 # Realistic Sky
          2619954303 # Recipe Browser
          2597324266 # Wing Slot Extra
          3092612587 # Revive Mod
          3101940607 # Boss Leaderboards
          3098311063 # Projectiles Be Gone
        ];
      };
    };
  };

  # Valheim server
  services.valheim = {
    enable = false;
    serverName = "Davies World";
    worldName = "DaviesWorld";
    password = "18tecoma";
  };

  # Automated backups
  # services.borgbackup.jobs = {
  #   servers = {
  #     startAt = "daily";
  #     compression = "auto,zstd";
  #     encryption.mode = "none";
  #     paths = [ "/srv/minecraft" "/var/lib/valheim/.config/unity3d/IronGate/Valheim" ];
  #     environment.BORG_RSH = "ssh -i /home/dominictdavies/.ssh/id_ed25519";
  #     repo = "ssh://ajzc3ma4@ajzc3ma4.repo.borgbase.com/./repo";
  #   };
  # };

  # Before changing this value read the documentation (https://nixos.org/nixos/options.html)
  system.stateVersion = "24.05";
}
