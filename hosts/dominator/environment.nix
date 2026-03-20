{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Tools
    unzip
    ffmpeg
    baobab
    qalculate-qt
    gpu-screen-recorder-gtk

    # Programming Packages
    nixfmt

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
