{
  inputs,
  my,
  self,
  ...
}:
{
  flake.nixosConfigurations.${my.hosts.computer.name} = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      {
        networking.hostName = my.hosts.computer.name;
        imports = with self.nixosModules; [
          common
          desktop
          development
          gaming
          graphics
          nfs-client
          printing
        ];

        # Do not modify! (https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion)
        system.stateVersion = "25.11";
      }
    ];
  };
}
