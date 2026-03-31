{ self, inputs, ... }:
{
  flake.nixosModules.dominoConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.common

        # Hardware
        self.nixosModules.dominoHardware
        self.nixosModules.framework

        # Interface
        self.nixosModules.bash
        self.nixosModules.desktop

        # Development
        self.nixosModules.docker
        self.nixosModules.vagrant

        # Extras
        self.nixosModules.lanFileSharing
        self.nixosModules.gaming
      ];

      environment.systemPackages = with pkgs; [
        # Tools
        nixfmt
        fastfetch
        unzip
        baobab
        remmina
        proton-vpn-cli

        # Programming Packages
        devenv
        rustup
        gcc
        cgdb
        clang-tools

        # Editors
        obsidian
        gimp
        inkscape
        vscode

        # Media
        vlc
        firefox
        discord
        spotify
      ];

      hardware = {
        enableAllFirmware = true;
        bluetooth.enable = true;
      };

      services = {
        fwupd.enable = true;
        printing.enable = true;
        gnome.gnome-keyring.enable = true;
      };

      networking = {
        hostName = "domino";
        networkmanager.enable = true;
      };

      # See `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
      system.stateVersion = "26.05"; # Did you read the comment?
    };
}
