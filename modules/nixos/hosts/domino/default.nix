{ self, inputs, ... }:
{
  flake.nixosConfigurations.domino = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.dominoConfiguration
    ];
  };
}
