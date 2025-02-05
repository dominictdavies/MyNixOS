{
  description = "NixOS configurations with Secure Boot";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft.url = "github:infinidoge/nix-minecraft";

    valheim-server = {
      url = "github:aidalgol/valheim-server-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, lanzaboote, ... }@inputs: {
    nixosConfigurations = {
      domino = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/domino/configuration.nix
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          inputs.home-manager.nixosModules.default
          lanzaboote.nixosModules.lanzaboote

          ({ pkgs, lib, ... }: {
            environment.systemPackages = [
              # For debugging and troubleshooting Secure Boot
              pkgs.sbctl
            ];

            # Replace systemd-boot with lanzaboote
            boot.loader.systemd-boot.enable = lib.mkForce false;
            boot.lanzaboote = {
              enable = true;
              pkiBundle = "/etc/secureboot";
            };
          })
        ];
      };

      dominion = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/dominion/configuration.nix
          inputs.nixos-hardware.nixosModules.acer-aspire-4810t
          inputs.home-manager.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
          inputs.valheim-server.nixosModules.default

          ({ pkgs, lib, ... }: {
            environment.systemPackages = [
              # For debugging and troubleshooting Secure Boot
              pkgs.sbctl
            ];

            # Replace systemd-boot with lanzaboote
            boot.loader.systemd-boot.enable = lib.mkForce false;
            boot.lanzaboote = {
              enable = true;
              pkiBundle = "/etc/secureboot";
            };
          })
        ];
      };
    };
  };
}
