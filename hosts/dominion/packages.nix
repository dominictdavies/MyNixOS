{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # NeoForge Server
    jdk21
    git-filter-repo
  ];
}
