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
        # GNOME (https://apps.gnome.org/en/)
        baobab
        gnome-calculator
        gnome-characters
        gnome-clocks
        gnome-connections
        decibels
        gnome-disk-utility
        gnome-font-viewer
        gnome-logs
        loupe
        gnome-music
        nautilus
        papers
        showtime
        snapshot
        gnome-system-monitor
        gnome-text-editor

        # Tools
        kitty
        proton-vpn-cli
        remmina
        scrcpy
        super-productivity

        # Editors
        gimp
        inkscape
        obsidian
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
          help-vagrant = "open https://cheatography.com/davbfr/cheat-sheets/vagrant-cheat-sheet/";
          help-gdb = "open https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf";
        };
      };

      # Make apps try to use Wayland
      environment.sessionVariables.NIXOS_OZONE_WL = 1;
    };
}
