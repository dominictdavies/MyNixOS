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

        # Interface
        self.nixosModules.desktop

        # Extras
        self.nixosModules.gaming
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
      ];

      # TODO: Make `nh` into a feature
      environment.sessionVariables = {
        # Allow `nh` to find flake directory
        NH_FLAKE = "/home/dominictdavies/MyNixOS";
      };

      services = {
        fwupd.enable = true;
        ratbagd.enable = true;
        printing.enable = true;
      };

      networking = {
        hostName = "dominator";
        networkmanager.enable = true;
      };

      # Local network file sharing
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
      services.samba = {
        enable = true;
      };

      # See `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
      system.stateVersion = "26.05"; # Did you read the comment?
    };
}
