{ inputs, ... }:
{
  # Nix-on-Droid (https://github.com/nix-community/nix-on-droid)
  flake.nixOnDroidConfigurations.domino = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
    pkgs = import inputs.nixpkgs { system = "aarch64-linux"; };
    modules = [ ../features/domino.nix ];
  };
}
