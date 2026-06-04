{ self, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      imports = with self.nixosModules; [
        niri
        gnome
        compatibility
        fileSharing
      ];

      environment.systemPackages = with pkgs; [
        # Terminal
        kitty
        ollama
        proton-vpn-cli

        # Tools
        obs-studio
        obsidian
        scrcpy
        super-productivity

        # Editors
        audacity
        gimp
        inkscape
        poppler-utils
        shotcut
        vscode

        # Media
        discord
        firefox
        spotify
      ];

      xdg.mime.defaultApplications = {
        "image/png" = "org.gnome.Loupe.desktop";
        "image/jpeg" = "org.gnome.Loupe.desktop";
        "application/pdf" = "org.gnome.Papers.desktop";
      };

      hardware.bluetooth.enable = true;

      services = {
        gnome.gnome-keyring.enable = true;
        printing.enable = true;
      };

      security = {
        polkit.enable = true;
        pam.services = {
          login.fprintAuth = false;
          greetd.fprintAuth = false;
        };
      };

      programs = {
        seahorse.enable = true;

        dconf.profiles.user.databases = [
          {
            settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
          }
        ];

        bash.shellAliases = {
          open = "xdg-open";
          help-keyboard = "open ~/MyNixOS/assets/information/keyboard_layout.png";
          help-cards = "open ~/MyNixOS/assets/information/card_functionality.png";
        };
      };

      # Make apps try to use Wayland
      environment.sessionVariables.NIXOS_OZONE_WL = 1;
    };
}
