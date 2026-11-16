{ my, ... }:
{
  flake.nixosModules.common = {
    programs.nh = {
      enable = true;

      clean = {
        enable = true;
        extraArgs = "--keep 5 --keep-since 30d";
      };
    };

    environment.sessionVariables.NH_FLAKE = my.repoRoot;
  };
}
