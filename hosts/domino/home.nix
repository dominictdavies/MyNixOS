{ config, pkgs, ... }:

{
  home.username = "dominictdavies";
  home.homeDirectory = "/home/dominictdavies";

  # Make sure to check the Home Manager release notes if you want to change this value
  home.stateVersion = "24.05";

  # Allow unfree and broken packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Terminal
    alacritty
    starship

    # Tools
    devenv
    unzip
    ffmpeg
    baobab
    qalculate-qt
    remmina

    # Programming Packages
    gcc
    dotnet-sdk
    clang-tools

    # Editors
    obsidian
    libreoffice
    vscode
    inkscape
    gimp

    # Web Browser
    firefox

    # Communication
    discord

    # Music & Video
    spotify
    vlc

    # Gaming
    steam
    prismlauncher

    # Custom Cursors
    posy-cursors
  ];

  home.sessionVariables = {
    # SDK cannot be found without specifying dotnet root
    DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet";
  };

  programs = {
    bash = {
      enable = true;

      shellAliases = {
        # General
        list = "ls -fl";
        clr = "clear";
        quit = "exit";

        # NixOS
        mynix-switch = "nh os switch";
        mynix-git-switch = "(cd ~/MyNixOS && git pull && nh os switch)";
        mynix-flake-switch = "(cd ~/MyNixOS && nix flake update && nh os switch)";
        mynix-full-switch = "(cd ~/MyNixOS && git pull && nix flake update && nh os switch)";

        # Domino
        open = "xdg-open";
        deltarune = "steam steam://rungameid/1671210 && exit";
      };
    };

    # Environment management depending on current directory
    direnv.enable = true;

    # Command-line fuzzy finder
    fzf.enable = true;

    # Smarter `cd` command
    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };

    # Let Home Manager install and manage itself
    home-manager.enable = true;
  };
}
