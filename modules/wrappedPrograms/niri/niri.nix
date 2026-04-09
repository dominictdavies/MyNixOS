{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      # TODO: Fix arrow binds for different output arrangements
      imports = [
        self.nixosModules.noctalia
      ];

      # niri (https://wiki.nixos.org/wiki/Niri)
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };

      # TODO: Ask for password rather than fingerprint
      # TODO: Add background
      programs.regreet = {
        enable = true;
        cageArgs = [
          "-s" # Allow virtual terminal switching.
          "-d" # Don't draw client side decorations when possible.
          "-m" # Set the multi-monitor behavior.
          "last" # Cage uses only the last connected monitor.
        ];
      };

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];
      };

      environment.systemPackages = with pkgs; [
        xwayland-satellite
        posy-cursors
      ];
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        "config.kdl".content = (builtins.readFile ./config.kdl);
      };
    };
}
