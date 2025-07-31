{ config, pkgs, ... }:

{
  home.username = "dominictdavies";
  home.homeDirectory = "/home/dominictdavies";

  # Make sure to check the Home Manager release notes if you want to change this value
  home.stateVersion = "24.05";

  # Allow unfree and broken packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    steamcmd
  ];

  programs = {
    bash = {
      enable = true;

      shellAliases = {
        # General
        list = "ls -fl";
        clr = "clear";
        quit = "exit";

        # NixOS
        anix-switch = "nh os switch";
        anix-git-switch = "(cd ~/MyNixOS && git pull && nh os switch)";
        anix-flake-switch = "(cd ~/MyNixOS && nix flake update && nh os switch)";
        anix-full-switch = "(cd ~/MyNixOS && git pull && nix flake update && nh os switch)";

        # tModLoader
        tmod-start = "sudo systemctl start tmodloader-server-third_calamity";
        tmod-stop = "sudo systemctl stop tmodloader-server-third_calamity";
        tmod-restart = "sudo systemctl restart tmodloader-server-third_calamity";
        tmod-status = "sudo systemctl status tmodloader-server-third_calamity";
        tmod-logs = "sudo journalctl -u tmodloader-server-third_calamity -f";
        tmod-run = "tmod-start && tmod-logs && tmod-stop";
      };
    };

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
