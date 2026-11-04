{ self, ... }:
{
  flake.nixosModules.niri =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.noctalia
      ];

      # niri (https://wiki.nixos.org/wiki/niri)
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
          xwayland-satellite
          kdePackages.breeze-icons
        ];
      };

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];
      };
    };
}
