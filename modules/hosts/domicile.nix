{ inputs, self, ... }:
{
  flake.nixosConfigurations.domicile = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      {
        networking.hostName = "domicile";
        imports = with self.nixosModules; [
          acer
          common
        ];

        # Do not modify! (https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion)
        system.stateVersion = "25.11";
      }
    ];
  };
}
