{
  flake.nixosModules.xdg =
    { pkgs, ... }:
    {
      xdg = {
        portal = {
          enable = true;
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
          ];
        };

        mime.defaultApplications = {
          "image/png" = "eog.desktop";
        };
      };
    };
}
