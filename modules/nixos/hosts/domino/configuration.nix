{ self, ... }:
{
  flake.nixosModules.dominoConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.common

        # Hardware
        self.nixosModules.dominoHardware
        self.nixosModules.framework

        # Interface
        self.nixosModules.bash
        self.nixosModules.desktop

        # Development
        self.nixosModules.docker
        self.nixosModules.vagrant

        # Extras
        self.nixosModules.lanFileSharing
        self.nixosModules.gaming
      ];

      environment.systemPackages = with pkgs; [
        # Tools
        nixfmt
        wineWow64Packages.stable
        winetricks
        unzip
        gpu-screen-recorder

        # Programming Packages
        devenv
        rustup
        gcc
        cgdb
        clang-tools
      ];

      hardware = {
        enableAllFirmware = true;
        bluetooth.enable = true;
      };

      services = {
        fwupd.enable = true;
        printing.enable = true;
      };

      networking = {
        hostName = "domino";
        networkmanager.enable = true;
      };

      # See `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
      system.stateVersion = "26.05"; # Did you read the comment?
    };
}
