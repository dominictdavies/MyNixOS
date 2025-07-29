{ config, ... }:

{
  environment.sessionVariables = {
    # Allow nh to find flake directory
    NH_FLAKE = "/home/dominictdavies/MyNixOS";
  };
}
