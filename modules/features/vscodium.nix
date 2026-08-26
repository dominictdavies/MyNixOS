{
  flake.nixosModules.vscodium =
    { pkgs, config, ... }:
    {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        extensions =
          with pkgs.vscode-extensions;
          [
            aaron-bond.better-comments
            davidanson.vscode-markdownlint
            james-yu.latex-workshop
            jnoortheen.nix-ide
            tamasfe.even-better-toml
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              publisher = "github";
              name = "vscode-pull-request-github";
              version = "0.156.0";
              sha256 = "sha256-Go9yiqCPZoJkHgHAaH42mawnZOCVlqMp5I+NG68RrPE=";
            }
            {
              publisher = "phil294";
              name = "git-log--graph";
              version = "0.1.35";
              sha256 = "sha256-xDR+3zBlkgPBQihGUFvTrtt8yH8gbcBg6pFKGtOEBHI=";
            }
            {
              publisher = "jeandeaual";
              name = "lilypond-syntax";
              version = "0.1.1";
              sha256 = "sha256-Lo4Opa9PaMlCxLRx+6n6r2f/El2+N0gEMAO6cd9l7Fo=";
            }
          ];
      };

      systemd.user.tmpfiles.rules = [
        "L+ %h/.config/VSCodium/User/settings.json - - - - ${config.my.repoRoot}/dotfiles/vscodium/settings.json"
        "L+ %h/.config/VSCodium/User/keybindings.json - - - - ${config.my.repoRoot}/dotfiles/vscodium/keybindings.json"
      ];
    };
}
