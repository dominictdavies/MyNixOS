{
  inputs,
  my,
  self,
  ...
}:
{
  flake.nixosConfigurations.${my.hosts.server.name} = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      {
        networking.hostName = my.hosts.server.name;
        imports = with self.nixosModules; [
          common
          laptop-server
          nfs-server
          syncthing
          vaultwarden
          webdav
          zfs
        ];

        # Do not modify! (https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion)
        system.stateVersion = "25.11";
      }
    ];
  };
}
