{ self, inputs, ... }:
{
  flake.nixosConfigurations.dominator = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.dominatorConfiguration
    ];
  };
}
