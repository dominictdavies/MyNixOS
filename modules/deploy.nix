{ self, inputs, lib, ... }:
{
  # deploy-rs (https://github.com/serokell/deploy-rs)
  flake.deploy.nodes = lib.mapAttrs (
    _: nixos:
    let
      inherit (nixos.pkgs.stdenv.hostPlatform) system;
    in
    {
      hostname = nixos.config.networking.hostName;
      profiles.system = {
        user = "root";
        sshUser = nixos.config.my.username;
        path = inputs.deploy-rs.lib.${system}.activate.nixos nixos;
      };
    }
  ) self.nixosConfigurations;

  # Validate the deploy schema with `nix flake check`
  flake.checks.x86_64-linux = inputs.deploy-rs.lib.x86_64-linux.deployChecks self.deploy;
}
