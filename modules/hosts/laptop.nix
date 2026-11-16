{
  inputs,
  my,
  self,
  ...
}:
{
  flake.nixosConfigurations.${my.hosts.laptop.name} = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      {
        networking.hostName = my.hosts.laptop.name;
        imports = with self.nixosModules; [
          common
          desktop
          development
          framework
          gaming
          nfs-client
        ];

        # Do not modify! (https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion)
        system.stateVersion = "25.11";
      }
    ];
  };
}
