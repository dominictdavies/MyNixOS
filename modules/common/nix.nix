{
  flake.nixosModules.common =
    { config, lib, ... }:
    {
      nix.settings = {
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [ "${config.my.username}" ];
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
