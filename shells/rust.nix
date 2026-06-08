let
  # Check for new commits at https://status.nixos.org
  pkgs =
    import
      (fetchTarball "https://github.com/NixOS/nixpkgs/archive/cbb5cf358f50aa6acc9efd6113b7bcfbc352cd73.tar.gz")
      { };
in
pkgs.mkShell {
  packages = with pkgs; [
    rustup
  ];
}
