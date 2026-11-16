{ my, self, ... }:
{
  flake.nixosModules.desktop = { pkgs, ... }: {
    imports = with self.nixosModules; [
      gnome-apps
      kitty
      niri
    ];

    environment = {
      systemPackages = with pkgs; [
        # Desktop
        papirus-icon-theme

        # CLI
        llama-cpp-rocm
        proton-vpn-cli

        # Tools
        anki
        easyeffects
        gpu-screen-recorder
        joplin-desktop
        lxappearance
        scrcpy
        super-productivity
        unzip
        vlc
        zip

        # Media
        firefox
        vesktop
      ];

      # Make apps try to use Wayland
      sessionVariables.NIXOS_OZONE_WL = 1;
    };

    xdg = {
      icons.fallbackCursorThemes = [ "black" ];

      mime.defaultApplications = {
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
      };
    };

    hardware.bluetooth.enable = true;

    services = {
      gnome.gnome-keyring.enable = true;
      power-profiles-daemon.enable = true;
      upower.enable = true;
    };

    security = {
      polkit.enable = true;

      # Realtime scheduling for PipeWire
      rtkit.enable = true;
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
        help-cards = "open ${my.repoRoot}/assets/information/card_functionality.png";
        help-keyboard = "open ${my.repoRoot}/assets/information/keyboard_layout.png";
        help-latex = "open ${my.repoRoot}/assets/information/latex_symbols.pdf";
      };

      gpu-screen-recorder = {
        enable = true;
        ui.enable = true;
      };
    };
  };
}
