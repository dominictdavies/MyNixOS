# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      inputs.nix-minecraft.nixosModules.minecraft-servers
      inputs.nix-tmodloader.nixosModules.tmodloader
    ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # Set your time zone.
  time.timeZone = "Australia/Perth";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dominictdavies = {
    isNormalUser = true;
    description = "Dominic Davies";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMbpqoIuCOeH2FjQmCdiqWsHAwKarHLW3JUIZMKsWLLB dominictdavies@gmail.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYWWLuj8iaTVE/2TQbXhosNCzQcRB+RhMvnPHcXfgxrH4XqpF0we5xF1tC94zFDzzn3VwYkQpL2kKSdtSVNCyGfywPIOZpSQc5zuiNfc50uajN+XBkECYdVgdiJLRPOwCIECyTllSyJUmA+KKjjNzKOGLCmBCkVhZ6XiJ1+ErxUzYy5PXYZip3N2OiIgS3nACtqpHe2Jo9bvP6kZi9QxpWa87C0M7zW65uHKDYusJxKlYe2fKBF6jfHniMN0ZuQvWaoZ3y4lGp5mlQf2QtUdNgm9197LpHsSWVAidbxVTa+2yDNpJv33rnOcAmhpSrfOrGNzOaqmObkCde8HCTsopg9YFT3ixmDRjMltd/+YfY+j/3BT331lRIBD1uDysQYb6+84LVdq9HnEQ6DzX69C2ZmX1koE9pCTq84KGzK6WReE6rf4AK0JXmnE23dTRV4GDnNIPW/y4nl+8XWRS6kusvVtACd6/shU48YjQke5Yxuf2JDMvUb2LMPUZQvRo4zgMd5Vmen9eutK599GrPbZsKh7Rm9jnSR+xHr7s7umYbPmTSe14t5Ka73uf80nj0SFRersKDxzZbPlIN9eUy8g6SajTXzGKiWdOBMP5hSCLpyOd26toWl3NW7hUrPrg4XTJbxxNKG33glYkrS6SAZF7mXrr3PLYavk/iwxPyVs8NOQ== dominictdavies@dominator"
    ];
  };

  home-manager = {
    # Also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    users = {
      "dominictdavies" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow nh to find flake directory
  environment.sessionVariables = {
    NH_FLAKE = "/home/dominictdavies/NixOS";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Modify the EFI Boot Manager
    efibootmgr

    # Yet another nix cli helper
    nh

    # Distributed version control system
    git

    # GitHub CLI tool
    gh
  ];

  # Prevent laptop from sleeping on lid close
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 443 7777 25565 ];
  networking.firewall.allowedUDPPorts = [ 2456 2457 7777 25565 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Nginx
  services.nginx = {
    enable = true;
    virtualHosts."dominictdavies.dev" = {
      forceSSL = true;  # Redirects HTTP to HTTPS
      sslCertificate = "/var/lib/acme/dominictdavies.dev/fullchain.pem";
      sslCertificateKey = "/var/lib/acme/dominictdavies.dev/key.pem";
      locations = {
        "/" = {
          proxyPass = "http://localhost:${toString config.services.grafana.settings.server.http_port}";  # Proxy to Grafana
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
    defaults.email = "dominictdavies@gmail.com";  # Required for Let's Encrypt
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

  # Minecraft server
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
  services.minecraft-servers = {
    enable = false;
    eula = true;

    servers = {
      edgetable_vegetable = {
        enable = false;
        package = pkgs.paperServers.paper;

        serverProperties = {
          level-name = "edgetable_vegetable";
          motd = "And by vegetables lets justr say edgetable";
          max-players = 7;
          level-seed = 7644964991330705060;
          difficulty = "hard";
          spawn-protection = 0;
          simulation-distance = 16;
          view-distance = 16;
          white-list = true;
          enforce-whitelist = true;
          enforce-secure-profile = false;
        };

        whitelist = {
          dominic = "d61aa5e5-2697-4b02-bc0d-164176c9169e";
          korbin = "9b47e99b-526d-4fc1-b2e1-8770ef34f7a1";
          annika = "ee4b4673-e0fe-436d-b2ae-095f2eea2ae1";
          kellen = "0de2dec5-5332-4375-9df5-83e64c665c70";
          ethan = "98bf0aab-a174-4afe-bd90-8cb5dbbae867";
          mason = "91694e45-1090-46fb-b83b-db40db0d3f48";
          chris = "63899fa9-9e5a-4a33-9a72-7510d0a79d1a";
        };

        operators = {
          dominic = "d61aa5e5-2697-4b02-bc0d-164176c9169e";
        };
      };

      nick_server = {
        enable = true;
        package = pkgs.paperServers.paper;

        serverProperties = {
          level-name = "nick_world";
          motd = "A Minecraft server";
          max-players = 2;
          difficulty = "hard";
          spawn-protection = 0;
          simulation-distance = 16;
          view-distance = 16;
          white-list = true;
          enforce-whitelist = true;
          enforce-secure-profile = false;
          allow-cheats = true;
        };

        whitelist = {
          dominic = "d61aa5e5-2697-4b02-bc0d-164176c9169e";
          nick = "58e6164a-b8a9-4c5a-8775-06e89bef2c1c";
          friend = "67ca1be4-56ad-489b-88b4-61e7866b253f";
        };

        operators = {
          dominic = "d61aa5e5-2697-4b02-bc0d-164176c9169e";
        };
      };
    };
  };

  # tModLoader server
  nixpkgs.overlays = [ inputs.nix-tmodloader.overlay ];
  services.tmodloader = {
    enable = true;
    servers = {
      third_calamity = {
        enable = true;
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
