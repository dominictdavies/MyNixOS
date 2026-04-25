{ self, inputs, ... }:
{
  flake.nixosConfigurations.domino = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      {
        networking.hostName = "domino";
        imports = with self.nixosModules; [
          common
          dominoHardware
          desktop
          docker
          vagrant
          gaming
        ];

        # Do not modify! (https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion)
        system.stateVersion = "25.11";
      }
    ];
  };
}
