{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Tools
    devenv
    unzip
    ffmpeg
    baobab
    qalculate-qt
    remmina
    vagrant
    cgdb

    # Programming Packages
    nixfmt
    rustup
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
    prismlauncher

    # Custom Cursors
    posy-cursors
  ];
}
