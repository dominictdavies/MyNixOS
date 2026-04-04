{ self, inputs, ... }:
{
  flake.nixosModules.swaylock =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.mySwaylock
      ];
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.mySwaylock = inputs.wrapper-modules.wrappers.swaylock.wrap {
        inherit pkgs;
        settings = {
          image = "/home/dominictdavies/Pictures/Wallpapers/Lined Desk Stanley Parable.png";
        };
      };
    };
}
