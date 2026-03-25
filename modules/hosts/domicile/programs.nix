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

        # Borg
        borg-mount = "mkdir -p ~/Borg && borg mount ssh://ajzc3ma4@ajzc3ma4.repo.borgbase.com/./repo ~/Borg";
        borg-unmount = "borg umount ~/Borg && rm -rf ~/Borg";
      };
    };

    # Command-line fuzzy finder
    fzf.fuzzyCompletion = true;

    # Smarter `cd` command
    zoxide = {
      enable = true;
      flags = [ "--cmd cd" ];
    };

    # Customisable shell prompt
    starship.enable = true;
  };
}
