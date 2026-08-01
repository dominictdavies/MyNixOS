{ self, ... }:
{
  flake.nixosModules.niri =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.noctalia
      ];

      # niri (https://wiki.nixos.org/wiki/niri)
      programs = {
        niri.enable = true;

        # Start niri automatically
        bash.loginShellInit = ''
          if [ "$(tty)" = "/dev/tty1" ] && [ -z "''${NIRI_AUTOSTARTED:-}" ]; then
            export NIRI_AUTOSTARTED=1
            exec niri-session
          fi
        '';
      };

      environment = {
        sessionVariables.NIRI_CONFIG = "${config.my.repoRoot}/dotfiles/niri.kdl";
        systemPackages = with pkgs; [
          xwayland-satellite
          bibata-cursors
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
