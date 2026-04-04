{ self, inputs, ... }:
{
  flake.nixosModules.swayidle =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.mySwayidle
      ];
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.mySwayidle = inputs.wrapper-modules.wrappers.swayidle.wrap {
        inherit pkgs;
        events = {
          lock = "swaylock";
        };
        timeouts.lock = {
          command = "swaylock";
          timeout = 10;
        }
      };
    };
}
