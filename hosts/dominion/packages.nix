{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Needed for NeoForge
    jdk21
  ];
}
