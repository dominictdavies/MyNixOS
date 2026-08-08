{ pkgs, ... }:

{
  packages = with pkgs; [
    nixd
    nixfmt
  ];
}
