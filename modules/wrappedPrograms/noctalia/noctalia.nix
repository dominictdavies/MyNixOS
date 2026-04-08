{ self, inputs, ... }:
{
  # TODO: Fix sessionMenu stretching too far on domino
  flake.nixosModules.noctalia =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
      ];

      programs.bash.shellAliases = {
        mynix-noctalia-push = "(cd ~/MyNixOS/modules/wrappedPrograms/noctalia && nix run nixpkgs#noctalia-shell ipc call state all > config.json && git add config.json && git commit -m \"Update noctalia settings\" && git push)";
      };
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
        inherit pkgs;
        settings = (builtins.fromJSON (builtins.readFile ./config.json)).settings;
      };
    };
}
