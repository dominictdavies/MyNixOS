{ ... }:

{
  programs = {
    bash = {
      enable = true;

      shellAliases = {
        # General
        list = "ls -flA";
        clr = "clear";
        quit = "exit";

        # NixOS
        mynix-switch = "nh os switch";
        mynix-sync-switch = "(cd ~/MyNixOS && git pull && nh os switch)";
        mynix-flake-switch = "(cd ~/MyNixOS && nix flake update && nh os switch && git add flake.lock && git commit -m \"Update flake\" && git push)";
        mynix-full-switch = "(cd ~/MyNixOS && git pull && nix flake update && nh os switch && git add flake.lock && git commit -m \"Update flake\" && git push)";

        # Dominator
        open = "xdg-open";
        deltarune = "steam steam://rungameid/1671210 && exit";
      };
    };

    # Steam
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    # Command-line fuzzy finder
    fzf.enable = true;

    # Smarter `cd` command
    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };

    # Customisable shell prompt
    starship.enable = true;

    # Let Home Manager install and manage itself
    home-manager.enable = true;
  };
}