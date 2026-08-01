{
  flake.nixosModules.nh =
    { config, ... }:
    {
      programs.nh.enable = true;
      environment.sessionVariables.NH_FLAKE = ${config.my.repoRoot};
    };
}
