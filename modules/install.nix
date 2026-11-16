{ inputs, my, ... }:
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

    runtimeEnv = {
      MY_REPO = my.repo;
      MY_REPO_ROOT = my.repoRoot;
      MY_USERNAME = my.username;
    };

    text = builtins.readFile ../scripts/install.sh;
  };
}
