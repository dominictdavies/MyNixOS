{ self, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      imports = with self.nixosModules; [
        niri
        compatibility
        printing
        fileSharing
      ];

      environment.systemPackages = with pkgs; [
        mousepad
        eog
        vlc
      ];

      xdg.mime.defaultApplications = {
        "image/png" = "org.gnome.eog.desktop";
        "image/jpeg" = "org.gnome.eog.desktop";
      };

      hardware.bluetooth.enable = true;

      services.gnome.gnome-keyring.enable = true;
      security = {
        polkit.enable = true;
        pam.services.login.fprintAuth = false;
      };

      # Make apps try to use Wayland
      environment.sessionVariables.NIXOS_OZONE_WL = 1;
    };
}
