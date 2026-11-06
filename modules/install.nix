{ inputs, ... }:
{
  # Run from a NixOS live USB:
  # sudo nix --extra-experimental-features "nix-command flakes" run github:dominictdavies/MyNixOS#install -- <host>
  flake.packages.x86_64-linux.install =
    let
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    in
    pkgs.writeShellApplication {
      name = "install";
      runtimeInputs = [
        inputs.disko.packages.x86_64-linux.disko-install
        pkgs.git
        pkgs.jq
        pkgs.mkpasswd
        pkgs.util-linux
      ];
      text = builtins.readFile ../scripts/install.sh;
    };
}
