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

        # Desktop
        self.nixosModules.niri
      ];

      environment.systemPackages = with pkgs; [
        # Tools
        nixfmt
        unzip
        baobab
        gpu-screen-recorder-gtk
        proton-vpn-cli

        # Editors
        obsidian
        gimp
        inkscape
        vscode

        # Cursors
        posy-cursors

        # Web Browser
        firefox

        # Communication
        discord

        # Music & Video
        spotify
        vlc

        # Gaming
        prismlauncher
      ];

      # See `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
      system.stateVersion = "26.05"; # Did you read the comment?
    };
}
