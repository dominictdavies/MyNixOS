{ self, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      imports = with self.nixosModules; [
        niri
        compatibility
        fileSharing
      ];

      environment.systemPackages = with pkgs; [
        # Shell
        kitty
        proton-vpn-cli

        # Tools
        nautilus
        baobab
        remmina
        scrcpy
        qalculate-gtk

        # Editors
        obsidian
        gimp
        inkscape

        # Media
        firefox
        discord
        spotify

        # Viewers
        mousepad
        eog
        vlc
      ];

      xdg.mime.defaultApplications = {
        "image/png" = "org.gnome.eog.desktop";
        "image/jpeg" = "org.gnome.eog.desktop";
      };

      hardware.bluetooth.enable = true;

      services = {
        gnome.gnome-keyring.enable = true;
        printing.enable = true;
      };

      security = {
        polkit.enable = true;
        pam.services.login.fprintAuth = false;
      };

      # Make apps try to use Wayland
      environment.sessionVariables.NIXOS_OZONE_WL = 1;
    };
}
