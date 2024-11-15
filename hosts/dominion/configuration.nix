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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dominictdavies = {
    isNormalUser = true;
    description = "Dominic Davies";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYWWLuj8iaTVE/2TQbXhosNCzQcRB+RhMvnPHcXfgxrH4XqpF0we5xF1tC94zFDzzn3VwYkQpL2kKSdtSVNCyGfywPIOZpSQc5zuiNfc50uajN+XBkECYdVgdiJLRPOwCIECyTllSyJUmA+KKjjNzKOGLCmBCkVhZ6XiJ1+ErxUzYy5PXYZip3N2OiIgS3nACtqpHe2Jo9bvP6kZi9QxpWa87C0M7zW65uHKDYusJxKlYe2fKBF6jfHniMN0ZuQvWaoZ3y4lGp5mlQf2QtUdNgm9197LpHsSWVAidbxVTa+2yDNpJv33rnOcAmhpSrfOrGNzOaqmObkCde8HCTsopg9YFT3ixmDRjMltd/+YfY+j/3BT331lRIBD1uDysQYb6+84LVdq9HnEQ6DzX69C2ZmX1koE9pCTq84KGzK6WReE6rf4AK0JXmnE23dTRV4GDnNIPW/y4nl+8XWRS6kusvVtACd6/shU48YjQke5Yxuf2JDMvUb2LMPUZQvRo4zgMd5Vmen9eutK599GrPbZsKh7Rm9jnSR+xHr7s7umYbPmTSe14t5Ka73uf80nj0SFRersKDxzZbPlIN9eUy8g6SajTXzGKiWdOBMP5hSCLpyOd26toWl3NW7hUrPrg4XTJbxxNKG33glYkrS6SAZF7mXrr3PLYavk/iwxPyVs8NOQ== dominictdavies@gmail.com"
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
  networking.firewall.allowedUDPPorts = [ 25565 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Minecraft server
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers = {
      edgy-veggies = {
        enable = true;
        package = pkgs.paperServers.paper;

        serverProperties = {
          server-ip = "58.179.210.39";
        };

        whitelist = {
          doomimic = "d61aa5e5-2697-4b02-bc0d-164176c9169e";
          kooark = "9b47e99b-526d-4fc1-b2e1-8770ef34f7a1";
          dash = "ee4b4673-e0fe-436d-b2ae-095f2eea2ae1";
          kelly_sama = "0de2dec5-5332-4375-9df5-83e64c665c70";
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
