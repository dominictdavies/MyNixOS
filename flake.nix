{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      domino = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/domino/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
        ];
      };

      dominion = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/dominion/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.nixos-hardware.nixosModules.acer-aspire-4810t
        ];
      };
    };
  };
}
