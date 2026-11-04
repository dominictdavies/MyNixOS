{
  flake.nixosModules.common =
    { lib, ... }:
    {
      nix.settings = {
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "bambu-studio"
          "steam"
          "steam-unwrapped"
        ];
    };
}
