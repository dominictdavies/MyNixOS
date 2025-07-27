{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dominictdavies";
  home.homeDirectory = "/home/dominictdavies";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Allow unfree and broken packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    steamcmd
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dominictdavies/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs = {
    # Bash
    bash = {
      enable = true;

      shellAliases = {
        # General
        list = "ls -fl";
        clr = "clear";
        quit = "exit";

        # NixOS
        anix-switch = "nh os switch";
        anix-git-switch = "(cd ~/NixOS && git pull && nh os switch)";
        anix-flake-switch = "(cd ~/NixOS && nix flake update && nh os switch)";
        anix-full-switch = "(cd ~/NixOS && git pull && nix flake update && nh os switch)";

        # Borg
        borg-mount = "mkdir -p ~/Borg && borg mount ssh://ajzc3ma4@ajzc3ma4.repo.borgbase.com/./repo ~/Borg";
        borg-unmount = "borg umount ~/Borg && rm -rf ~/Borg";

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
