{ self, ... }:
{
  flake.nixosModules.noctalia =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.noctalia-shell ];
      environment.variables.NOCTALIA_SETTINGS_FILE = self + "/modules/wrappedPrograms/noctalia/config.json";

      programs.bash.shellAliases = {
        mynix-noctalia-config = "(cd ~/MyNixOS/modules/wrappedPrograms/noctalia && nix run nixpkgs#noctalia-shell ipc call state all > config.json)";
      };
    };
}
