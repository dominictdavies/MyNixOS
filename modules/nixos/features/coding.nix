{
  flake.nixosModules.coding =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nixfmt
        rustup
        gcc
        cgdb
        clang-tools
        devenv
        vscode
      ];
    };
}
