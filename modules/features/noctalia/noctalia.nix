{ inputs, ... }:
{
  flake.nixosModules.noctalia =
    { pkgs, ... }:
    {
      # Noctalia (https://docs.noctalia.dev/v5/configuration)
      environment.systemPackages = [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      environment.variables.NOCTALIA_CONFIG_HOME = self + "/modules/features/noctalia";
    };
}
