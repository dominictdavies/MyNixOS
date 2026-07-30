{
  flake.nixosModules.nh = {
    programs.nh.enable = true;
    environment.sessionVariables.NH_FLAKE = "$HOME/MyNixOS/";
  };
}
