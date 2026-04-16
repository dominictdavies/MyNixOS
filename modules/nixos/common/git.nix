{
  flake.nixosModules.common = {
    programs.git = {
      enable = true;
      lfs.enable = true;
    };
  };
}
