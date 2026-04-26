let
  # Check for new commits at https://status.nixos.org.
  pkgs =
    import
      (fetchTarball "https://github.com/NixOS/nixpkgs/archive/01fbdeef22b76df85ea168fbfe1bfd9e63681b30.tar.gz")
      { };
in
pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [
        kagglehub
        transformers
        torch
        accelerate
      ]
    ))
  ];
}
