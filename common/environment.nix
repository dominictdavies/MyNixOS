{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Secrets
    sops

    # NixOS CLI Tool
    nh

    # Git & GitHub
    git
    gh
  ];

  environment.sessionVariables = {
    # Allow nh to find flake directory
    NH_FLAKE = "/home/dominictdavies/MyNixOS";
  };
}
