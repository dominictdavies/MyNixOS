{ self, inputs, ... }:
{
  flake.nixosModules.dominatorConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.dominatorHardware
        self.nixosModules.nvidia

        self.nixosModules.niri
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };

      # See `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
      system.stateVersion = "26.05"; # Did you read the comment?
    };
}
