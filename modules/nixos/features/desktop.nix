{ self, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.niri
        self.nixosModules.gtk
      ];

      environment.systemPackages = with pkgs; [
        # Locker
        swaylock
        swayidle

        # Viewers
        mousepad
        eog
        vlc
      ];

      # Security
      security = {
        polkit.enable = true;
        pam.services = {
          swaylock = { };
          login.fprintAuth = false;
        };
      };
      services.gnome.gnome-keyring.enable = true;

      # Make apps try to use Wayland
      environment.sessionVariables.NIXOS_OZONE_WL = 1;
    };
}
