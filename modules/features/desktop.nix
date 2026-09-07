{ self, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, config, ... }:
    {
      imports = with self.nixosModules; [
        gnome
        kitty
        niri
      ];

      environment.systemPackages = with pkgs; [
        # Desktop
        papirus-icon-theme

        # CLI
        opencode
        proton-vpn-cli

        # Tools
        joplin-desktop
        scrcpy
        super-productivity
        vlc

        # Media
        firefox
        vesktop
      ];

      xdg.mime.defaultApplications = {
        "audio/flac" = "vlc.desktop";
        "audio/mp4" = "vlc.desktop";
        "audio/mpeg" = "vlc.desktop";
        "audio/ogg" = "vlc.desktop";
        "audio/wav" = "vlc.desktop";

        "video/mp4" = "vlc.desktop";
        "video/webm" = "vlc.desktop";
        "video/quicktime" = "vlc.desktop";
        "video/x-matroska" = "vlc.desktop";
        "video/x-msvideo" = "vlc.desktop";

        "image/bmp" = "org.gnome.Loupe.desktop";
        "image/gif" = "org.gnome.Loupe.desktop";
        "image/jpeg" = "org.gnome.Loupe.desktop";
        "image/png" = "org.gnome.Loupe.desktop";
        "image/webp" = "org.gnome.Loupe.desktop";

        "application/pdf" = "org.gnome.Papers.desktop";
      };

      hardware.bluetooth.enable = true;

      services = {
        power-profiles-daemon.enable = true;
        upower.enable = true;
        gnome.gnome-keyring.enable = true;

        # Printing (https://wiki.nixos.org/wiki/Printing)

        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };

        printing = {
          enable = true;
          drivers = with pkgs; [
            cups-filters
            cups-browsed
          ];
        };
      };

      security = {
        polkit.enable = true;
        pam.services.login.enableGnomeKeyring = true;
      };

      programs = {
        seahorse.enable = true;

        dconf.profiles.user.databases = [
          {
            settings."org/gnome/desktop/interface" = {
              color-scheme = "prefer-dark";
              icon-theme = "Papirus-Dark";
            };
          }
        ];

        bash.shellAliases = {
          open = "xdg-open";
          help-cards = "open ${config.my.repoRoot}/assets/information/card_functionality.png";
          help-keyboard = "open ${config.my.repoRoot}/assets/information/keyboard_layout.png";
          help-latex = "open ${config.my.repoRoot}/assets/information/latex_symbols.pdf";
        };
      };

      # Make apps try to use Wayland
      environment.sessionVariables.NIXOS_OZONE_WL = 1;
    };
}
