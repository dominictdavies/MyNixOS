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
        gnumake
        check
        devenv

        # Formatters
        nixfmt

        # Editors
        vscode
      ];
    };
}
