{
  flake.nixosModules.coding =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Languages
        rustup
        gcc

        # Tools
        cgdb
        clang-tools
        devenv

        # Formatters
        nixfmt

        # Editors
        vscode
      ];
    };
}
