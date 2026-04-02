{
  flake.nixosModules.xdg =
    { pkgs, ... }:
    {
      xdg = {
        portal = {
          enable = true;
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal-gnome
          ];
          config.common.default = [ "gnome" ];
        };

        mime.defaultApplications = {
          "image/png" = "org.gnome.eog.desktop";
          "image/jpeg" = "org.gnome.eog.desktop";
        };
      };
    };
}
