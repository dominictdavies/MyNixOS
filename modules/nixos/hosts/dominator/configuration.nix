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
        # Nix
        nh
        nixfmt

        # Git
        git
        git-lfs
        git-filter-repo

        # Tools
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

        # Media
        vlc
        firefox
        discord
        spotify

        # Gaming
        prismlauncher
      ];

      environment.sessionVariables = {
        # Allow `nh` to find flake directory
        NH_FLAKE = "/home/dominictdavies/MyNixOS";
      };

      # See `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
      system.stateVersion = "26.05"; # Did you read the comment?
    };
}
