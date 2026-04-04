{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.noctalia
      ];

      # niri (https://wiki.nixos.org/wiki/Niri)
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };

      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "niri-session";
            user = "dominictdavies";
          };
        };
      };

      # TODO: Move non-essential packeges out of wrappped niri
      environment.systemPackages = with pkgs; [
        # Important
        xwayland-satellite

        # Shell
        kitty
        fastfetch
        proton-vpn-cli

        # Tools
        nautilus
        baobab
        remmina
        scrcpy
        qalculate-gtk # TODO: Get qalculate to find dark mode

        # Editors
        obsidian
        gimp
        inkscape
        vscode

        # Media
        firefox
        discord
        spotify
        steam

        # Cursor
        posy-cursors
      ];
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings = {

          # Important Software (https://github.com/niri-wm/niri/wiki/Important-Software)
          spawn-at-startup = [
            (lib.getExe self'.packages.myNoctalia)
          ];

          # Input (https://github.com/niri-wm/niri/wiki/Configuration:-Input)
          input.keyboard.xkb.layout = "au";
          input.touchpad = {
            tap = _: { };
            tap-button-map = "left-right-middle";
            click-method = "clickfinger";
            natural-scroll = _: { };
            scroll-factor = 0.5;
            scroll-method = "two-finger";
          };

          # Outputs (https://github.com/niri-wm/niri/wiki/Configuration:-Outputs)
          outputs = {
            "HDMI-A-1" = {
              mode = "2560x1080@60.000";
              position = _: {
                props = {
                  x = 0;
                  y = 360;
                };
              };
            };
            "DP-1" = {
              mode = "2560x1440@143.972";
              position = _: {
                props = {
                  x = 2560;
                  y = 0;
                };
              };
            };
          };

          # Key Bindings (https://github.com/niri-wm/niri/wiki/Configuration:-Key-Bindings)
          binds = {

            # Niri
            "Mod+Ctrl+Alt+Slash".show-hotkey-overlay = _: { };
            "Mod+Ctrl+Alt+Q".quit = _: { };

            "Mod+Q".close-window = _: { };
            "Mod+C".center-column = _: { };
            "Mod+D".maximize-column = _: { };
            "Mod+F".fullscreen-window = _: { };
            "Mod+G".toggle-windowed-fullscreen = _: { };
            "Mod+V".toggle-window-floating = _: { };
            "Mod+O".toggle-overview = _: { };
            "Mod+S".screenshot = _: { };
            "Mod+L".spawn-sh = "swaylock";

            "Mod+Left".focus-column-or-monitor-left = _: { };
            "Mod+Right".focus-column-or-monitor-right = _: { };
            "Mod+Up".focus-window-or-workspace-up = _: { };
            "Mod+Down".focus-window-or-workspace-down = _: { };

            "Mod+WheelScrollUp".focus-column-or-monitor-left = _: { };
            "Mod+WheelScrollDown".focus-column-or-monitor-right = _: { };
            "Mod+Alt+WheelScrollUp".focus-window-or-workspace-up = _: { };
            "Mod+Alt+WheelScrollDown".focus-window-or-workspace-down = _: { };

            "Mod+1".focus-workspace = 1;
            "Mod+2".focus-workspace = 2;
            "Mod+3".focus-workspace = 3;
            "Mod+4".focus-workspace = 4;
            "Mod+5".focus-workspace = 5;
            "Mod+6".focus-workspace = 6;
            "Mod+7".focus-workspace = 7;
            "Mod+8".focus-workspace = 8;
            "Mod+9".focus-workspace = 9;
            "Mod+0".focus-workspace = 10;

            "Mod+Shift+Left".move-column-left-or-to-monitor-left = _: { };
            "Mod+Shift+Right".move-column-right-or-to-monitor-right = _: { };
            "Mod+Shift+Up".move-window-up-or-to-workspace-up = _: { };
            "Mod+Shift+Down".move-window-down-or-to-workspace-down = _: { };

            "Mod+Shift+WheelScrollUp".move-column-left-or-to-monitor-left = _: { };
            "Mod+Shift+WheelScrollDown".move-column-right-or-to-monitor-right = _: { };
            "Mod+Shift+Alt+WheelScrollUp".move-window-up-or-to-workspace-up = _: { };
            "Mod+Shift+Alt+WheelScrollDown".move-window-down-or-to-workspace-down = _: { };

            "Mod+Shift+Comma".consume-or-expel-window-left = _: { };
            "Mod+Shift+Period".consume-or-expel-window-right = _: { };

            "Mod+Shift+1".move-column-to-workspace = 1;
            "Mod+Shift+2".move-column-to-workspace = 2;
            "Mod+Shift+3".move-column-to-workspace = 3;
            "Mod+Shift+4".move-column-to-workspace = 4;
            "Mod+Shift+5".move-column-to-workspace = 5;
            "Mod+Shift+6".move-column-to-workspace = 6;
            "Mod+Shift+7".move-column-to-workspace = 7;
            "Mod+Shift+8".move-column-to-workspace = 8;
            "Mod+Shift+9".move-column-to-workspace = 9;
            "Mod+Shift+0".move-column-to-workspace = 10;

            "Mod+Ctrl+Left".set-column-width = "-5%";
            "Mod+Ctrl+Right".set-column-width = "+5%";
            "Mod+Ctrl+Up".set-window-height = "-5%";
            "Mod+Ctrl+Down".set-window-height = "+5%";

            "Mod+Ctrl+WheelScrollUp".set-column-width = "-5%";
            "Mod+Ctrl+WheelScrollDown".set-column-width = "+5%";
            "Mod+Ctrl+Alt+WheelScrollUp".set-window-height = "-5%";
            "Mod+Ctrl+Alt+WheelScrollDown".set-window-height = "+5%";

            # Apps (AEKQUVXYZ remain)
            "Mod+Alt+Return".spawn-sh = "kitty";
            "Mod+Alt+F".spawn-sh = "kitty --hold fastfetch";
            "Mod+Alt+H".spawn-sh = "kitty protonvpn connect";
            "Mod+Alt+J".spawn-sh = "kitty protonvpn disconnect";

            "Mod+Alt+N".spawn-sh = "nautilus";
            "Mod+Alt+W".spawn-sh = "baobab";
            "Mod+Alt+R".spawn-sh = "remmina";
            "Mod+Alt+P".spawn-sh = "scrcpy";
            "Mod+Alt+M".spawn-sh = "qalculate-gtk";
            "XF86Calculator".spawn-sh = "qalculate-gtk";

            "Mod+Alt+O".spawn-sh = "obsidian";
            "Mod+Alt+G".spawn-sh = "gimp";
            "Mod+Alt+I".spawn-sh = "inkscape";
            "Mod+Alt+C".spawn-sh = "code";

            "Mod+Alt+B".spawn-sh = "firefox";
            "Mod+Alt+D".spawn-sh = "discord";
            "Mod+Alt+L".spawn-sh = "spotify";
            "Mod+Alt+S".spawn-sh = "steam";
            "Mod+Alt+T".spawn-sh = "deltarune";

            # Noctalia
            "Ctrl+Alt+Delete".spawn-sh = "noctalia-shell ipc call sessionMenu toggle";
            "Ctrl+Alt+Slash".spawn-sh = "noctalia-shell ipc call launcher toggle";

            "XF86AudioPlay".spawn-sh = "noctalia-shell ipc call media toggle";
            "XF86AudioStop".spawn-sh = "noctalia-shell ipc call media stop";
            "XF86AudioPrev".spawn-sh = "noctalia-shell ipc call media previous";
            "XF86AudioNext".spawn-sh = "noctalia-shell ipc call media next";
            "XF86AudioMute".spawn-sh = "noctalia-shell ipc call volume muteOutput";
            "XF86AudioLowerVolume".spawn-sh = "noctalia-shell ipc call volume decrease";
            "XF86AudioRaiseVolume".spawn-sh = "noctalia-shell ipc call volume increase";

            "XF86Explorer".spawn-sh = "noctalia-shell ipc call systemMonitor toggle";
            "XF86Search".spawn-sh = "noctalia-shell ipc call launcher toggle";
            "XF86Tools".spawn-sh = "noctalia-shell ipc call controlCenter toggle";

          };

          # Layout (https://github.com/niri-wm/niri/wiki/Configuration:-Layout)
          layout = {
            gaps = 16;
            focus-ring = {
              width = 8;
              active-gradient = _: {
                props = {
                  from = "#37f499";
                  to = "#04d1f9";
                  angle = 45;
                };
              };

              inactive-gradient = _: {
                props = {
                  from = "#808080";
                  to = "#404040";
                  angle = 45;
                };
              };
            };
          };

          # Miscellaneous (https://github.com/niri-wm/niri/wiki/Configuration:-Miscellaneous)
          cursor = {
            xcursor-theme = "Posy_Cursor_Black";
            xcursor-size = 32;
          };
          hotkey-overlay = {
            # TODO: Remove unbound binds from overlay
            skip-at-startup = _: { };
          };

        };
      };
    };
}
