{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # NixOS CLI Tool
    nh

    # Git & GitHub
    git
    git-lfs
    gh
  ];

  environment.sessionVariables = {
    # Allow nh to find flake directory
    NH_FLAKE = "/home/dominictdavies/MyNixOS";
  };
}
