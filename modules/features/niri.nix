{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    { config, pkgs, ... }:
    let
      # From the 3akev/xwayland-satellite fix-dropdown-menu branch
      xwayland-satellite = pkgs.xwayland-satellite.overrideAttrs (old: {
        version = "fix-dropdown-menu";
        src = inputs.xwayland-satellite;
        cargoDeps = old.cargoDeps.overrideAttrs (deps: {
          vendorStaging = deps.vendorStaging.overrideAttrs (s: {
            outputHash = "sha256-s1gl9eR6Mt2QLrhfcowstPFjzwE/lz4PJhJzWYHoIHg=";
          });
        });
      });
    in
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
          command = "${pkgs.niri}/bin/niri-session";
          user = "dominictdavies";
        };
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
