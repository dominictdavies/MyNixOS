{ self, ... }:
{
  flake.nixosModules.dominatorConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        # TODO: With self
        self.nixosModules.common

        # Hardware
        self.nixosModules.dominatorHardware
        self.nixosModules.nvidia

        # Interface
        self.nixosModules.bash
        self.nixosModules.desktop

        # Development
        self.nixosModules.coding

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
        ratbagd.enable = true;
        printing.enable = true;
      };

      networking = {
        hostName = "dominator";
        networkmanager.enable = true;
      };

      # See `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
      system.stateVersion = "26.05"; # Did you read the comment?
    };
}
