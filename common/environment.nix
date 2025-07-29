{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # NixOS CLI Tool
      nh

      # Git & GitHub
      git
      gh
    ];

    sessionVariables = {
      # Allow nh to find flake directory
      NH_FLAKE = "/home/dominictdavies/MyNixOS";
    };
  };
}
