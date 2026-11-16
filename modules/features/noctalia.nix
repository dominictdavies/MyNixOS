{ inputs, my, ... }:
{
  flake.nixosModules.noctalia = { pkgs, ... }: {
    # Noctalia (https://docs.noctalia.dev/v5/configuration)
    environment = {
      systemPackages = [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

        # Required by scripts
        pkgs.jo
      ];

      sessionVariables.NOCTALIA_CONFIG_HOME = "${my.repoRoot}/dotfiles/";
    };
  };
}
