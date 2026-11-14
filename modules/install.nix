{ inputs, ... }:
let
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in
{
  flake.packages.x86_64-linux.install = pkgs.writeShellApplication {
    name = "install";
    runtimeInputs = [
      pkgs.cryptsetup
      pkgs.git
      pkgs.mkpasswd
      pkgs.nix-output-monitor
      pkgs.nixos-install-tools
      pkgs.openssh
      pkgs.util-linux
    ];
    text = builtins.readFile ../scripts/install.sh;
  };
}
