{ self, inputs, ... }:
{
  flake.nixosModules.dominatorConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.common

        # Hardware
        self.nixosModules.dominatorHardware
        self.nixosModules.nvidia

        # Interface
        self.nixosModules.bash
        self.nixosModules.desktop

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
        gpu-screen-recorder
        proton-vpn-cli

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
        ratbagd.enable = true;
        printing.enable = true;
        gnome.gnome-keyring.enable = true;
      };

      networking = {
        hostName = "dominator";
        networkmanager.enable = true;
      };

      # See `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
      system.stateVersion = "26.05"; # Did you read the comment?
    };
}
