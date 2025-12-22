{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # NixOS CLI Tool
    nh

    # Git
    git
    git-lfs
    git-filter-repo
    gh
  ];

  environment.sessionVariables = {
    # Allow nh to find flake directory
    NH_FLAKE = "/home/dominictdavies/MyNixOS";
  };
}
