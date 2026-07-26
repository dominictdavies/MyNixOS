let
  # Check for new commits at https://status.nixos.org
  pkgs =
    import
      (fetchTarball "https://github.com/NixOS/nixpkgs/archive/335f0738cb2fa9708f3f428e39d2eae975d1338d.tar.gz")
      { };
in
pkgs.mkShell {
  packages = with pkgs; [
    nixd
    nixfmt
  ];
}
