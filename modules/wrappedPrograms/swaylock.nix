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
          color = "00ff00";
          font-size = 24;
          indicator-idle-visible = false;
          indicator-radius = 100;
          line-color = "ffffff";
          show-failed-attempts = true;
        };
      };
    };
}
