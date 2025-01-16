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
    ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dominion"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Perth";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

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

  # Enable docker
  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dominictdavies = {
    isNormalUser = true;
    description = "Dominic Davies";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfj/1jtBKFkTm8pvw9uIK70KxZqTIf+cTDBXgJdiyYJjSFcWuXIznFs63CdGCPBp5nDJHE2ka92I8eIzHC8k5/kv7pU4yRZW/3IIDai1AiD56vA1vDxBf75OeHIqrYs3WBT1IJvVl57+yerPKdE11rWaKqK+M59yfTzzzmBWT75j3wtw5oabuljw+NxVgVx4oH+xj0plshShj+TrQ7FaAAFIsxQK89FRIQU8v5sTh1BIY5jcFUWOv6S+lurqL//lVF4F3ulMn0Lp7rELP4/uZsMgm4EsZmWrdXzEx4HfCiyFdWIgNqkdVZQJaPqdvWF/DsHuh0spryC+zdLjILR8rov3tgJwvxLLruhraw0xZnIvJTZWi70SC9xjn0TVU2aWblQNmj92SIJ8AeXPJESwu/rr+F1PbVLdnZ+JI3tbTW7N8/mlMSMO5F0P4/9GmE6FtOUsBbX3BydXFPRDavc4vimQusdmfBEm2553sKISLWV3uS7KBf6lHxxqn9NupVIz8= dominictdavies@domino"
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
    FLAKE = "/home/dominictdavies/NixOS";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Modify EFI boot manager
    efibootmgr

    # NixOS CLI Tool
    nh

    # Git & GitHub
    git
    gh
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

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
  networking.firewall.allowedTCPPorts = [ 25565 ];
  networking.firewall.allowedUDPPorts = [ 24454 25565 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Minecraft server
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers = {
      nick_server = {
        enable = true;
        package = pkgs.paperServers.paper;

        serverProperties = {
          level-name = "nick_world";
          motd = "A Minecraft server";
          max-players = 2;
          difficulty = 2;
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
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
