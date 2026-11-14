{ self, ... }:
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
        user = config.my.username;
      };
    };

    environment = {
      sessionVariables.NIRI_CONFIG = "${config.my.repoRoot}/dotfiles/niri.kdl";
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
