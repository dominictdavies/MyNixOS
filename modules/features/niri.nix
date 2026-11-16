{ my, self, ... }:
{
  flake.nixosModules.niri = { config, pkgs, ... }: {
    imports = with self.nixosModules; [ noctalia ];

    # Niri (https://wiki.nixos.org/wiki/niri)
    programs.niri.enable = true;

    # Greetd (https://wiki.nixos.org/wiki/Greetd)
    services.greetd = {
      enable = true;

      settings.default_session = {
        command = "${config.programs.niri.package}/bin/niri-session";
        user = my.username;
      };
    };

    # Unlock the GNOME keyring when logging in through greetd
    security.pam.services.greetd.enableGnomeKeyring = true;

    environment = {
      sessionVariables.NIRI_CONFIG = "${my.repoRoot}/dotfiles/niri.kdl";
      systemPackages = with pkgs; [
        kdePackages.breeze-icons
        xwayland-satellite
      ];
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };
  };
}
