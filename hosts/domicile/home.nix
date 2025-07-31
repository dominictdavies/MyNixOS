{ config, pkgs, ... }:

{
  home.username = "dominictdavies";
  home.homeDirectory = "/home/dominictdavies";

  # Make sure to check the Home Manager release notes if you want to change this value
  home.stateVersion = "24.05";

  # Allow unfree and broken packages
  nixpkgs.config.allowUnfree = true;

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

        # Borg
        borg-mount = "mkdir -p ~/Borg && borg mount ssh://ajzc3ma4@ajzc3ma4.repo.borgbase.com/./repo ~/Borg";
        borg-unmount = "borg umount ~/Borg && rm -rf ~/Borg";
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
