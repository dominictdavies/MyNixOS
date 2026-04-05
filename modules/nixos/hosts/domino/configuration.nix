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
        self.nixosModules.coding
        self.nixosModules.docker
        self.nixosModules.vagrant

        # Extras
        self.nixosModules.lanFileSharing
        self.nixosModules.compatibility
        self.nixosModules.gaming
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
