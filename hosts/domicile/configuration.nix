# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Boot initrd for encyption unlock
  boot.initrd.network.enable = true;

  boot.initrd.kernelModules = [ "r8169" ];
  boot.initrd.secrets = {
    "/etc/ssh/ssh_host_ed25519_key" = "/etc/ssh/ssh_host_ed25519_key";
  };

  boot.initrd.network.ssh = {
    enable = true;
    port = 22;
    hostKeys = [ "/etc/ssh/ssh_host_ed25519_key" ];
    authorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHAyFBu6MAI9ddjljconVOKvrV0OIMdarMmf+HlTlTS0 dominictdavies@domino"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYWWLuj8iaTVE/2TQbXhosNCzQcRB+RhMvnPHcXfgxrH4XqpF0we5xF1tC94zFDzzn3VwYkQpL2kKSdtSVNCyGfywPIOZpSQc5zuiNfc50uajN+XBkECYdVgdiJLRPOwCIECyTllSyJUmA+KKjjNzKOGLCmBCkVhZ6XiJ1+ErxUzYy5PXYZip3N2OiIgS3nACtqpHe2Jo9bvP6kZi9QxpWa87C0M7zW65uHKDYusJxKlYe2fKBF6jfHniMN0ZuQvWaoZ3y4lGp5mlQf2QtUdNgm9197LpHsSWVAidbxVTa+2yDNpJv33rnOcAmhpSrfOrGNzOaqmObkCde8HCTsopg9YFT3ixmDRjMltd/+YfY+j/3BT331lRIBD1uDysQYb6+84LVdq9HnEQ6DzX69C2ZmX1koE9pCTq84KGzK6WReE6rf4AK0JXmnE23dTRV4GDnNIPW/y4nl+8XWRS6kusvVtACd6/shU48YjQke5Yxuf2JDMvUb2LMPUZQvRo4zgMd5Vmen9eutK599GrPbZsKh7Rm9jnSR+xHr7s7umYbPmTSe14t5Ka73uf80nj0SFRersKDxzZbPlIN9eUy8g6SajTXzGKiWdOBMP5hSCLpyOd26toWl3NW7hUrPrg4XTJbxxNKG33glYkrS6SAZF7mXrr3PLYavk/iwxPyVs8NOQ== dominictdavies@dominator"
    ];
  };

  boot.initrd.network.postCommands = ''
    ip link set enp2s0f1 up
    ip addr add 10.1.1.200/24 dev enp2s0f1
    ip route add default via 10.1.1.1
    echo "nameserver 8.8.8.8" > /etc/resolv.conf
  '';

  # Networking
  networking.networkmanager.enable = true;
  networking.hostName = "domicile";
  networking.defaultGateway = "10.1.1.1";
  networking.nameservers = [ "8.8.8.8" ];

  # Static IP
  networking.interfaces.enp2s0f1.ipv4.addresses = [ {
    address = "10.1.1.200";
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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHAyFBu6MAI9ddjljconVOKvrV0OIMdarMmf+HlTlTS0 dominictdavies@domino"
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
  networking.firewall.allowedTCPPorts = [ 22 ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
