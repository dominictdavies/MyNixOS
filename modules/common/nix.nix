let
  unfreePackages = [
    "steam"
    "steam-unwrapped"
  ];
in
{
  flake.nixosModules.common = { lib, ... }: {
    nix.settings = {
      auto-optimise-store = true;
      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) unfreePackages;
  };
}
