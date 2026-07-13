{
  flake.nixosModules.nh = {
    programs.nh.enable = true;
    environment.variables.NH_FLAKE = "$HOME/MyNixOS";
  };
}
