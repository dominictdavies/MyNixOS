{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    noctalia.url = "github:noctalia-dev/noctalia";

    # Fork with dropdown-menu fix (https://github.com/3akev/xwayland-satellite/tree/fix-dropdown-menu)
    xwayland-satellite.url = "github:3akev/xwayland-satellite/fix-dropdown-menu";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
