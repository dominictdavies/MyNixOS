{ self, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.niri
        self.nixosModules.swaylock
      ];

      environment.systemPackages = with pkgs; [
        swayidle

        # Viewers
        mousepad
        eog
        vlc
      ];

      xdg.mime.defaultApplications = {
        "image/png" = "org.gnome.eog.desktop";
        "image/jpeg" = "org.gnome.eog.desktop";
      };

      services.gnome.gnome-keyring.enable = true;
      security = {
        polkit.enable = true;
        pam.services = {
          swaylock = { };
          login.fprintAuth = false;
        };
      };

      # Make apps try to use Wayland
      environment.sessionVariables.NIXOS_OZONE_WL = 1;
    };
}
