{ self, inputs, ... }:
{
  # TODO: Add dominion and domicile
  flake.nixosConfigurations.dominator = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      {
        networking.hostName = "dominator";
        imports = with self.nixosModules; [
          common
          dominatorHardware
          desktop
          coding
          gaming
        ];

        # Do not modify! (https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion)
        system.stateVersion = "25.11";
      }
    ];
  };
}
