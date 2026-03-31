{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.noctalia
      ];

      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };

      environment.systemPackages = with pkgs; [
        kitty
        scrcpy
        nautilus
        qalculate-gtk # TODO: Get qalculate to find dark mode
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
          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
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
            "Mod+Shift+Slash".show-hotkey-overlay = _: { };

            "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
            "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
            "Mod+P".spawn-sh = lib.getExe pkgs.scrcpy;

            "Mod+Q".close-window = _: { };
            "Mod+F".maximize-column = _: { };
            "Mod+Shift+F".toggle-window-floating = _: { };
            "Mod+G".fullscreen-window = _: { };
            "Mod+C".center-column = _: { };

            "Mod+Left".focus-column-left = _: { };
            "Mod+Right".focus-column-right = _: { };
            "Mod+Up".focus-window-up = _: { };
            "Mod+Down".focus-window-down = _: { };

            "Mod+WheelScrollDown".focus-column-left = _: { };
            "Mod+WheelScrollUp".focus-column-right = _: { };
            "Mod+Ctrl+WheelScrollDown".focus-workspace-down = _: { };
            "Mod+Ctrl+WheelScrollUp".focus-workspace-up = _: { };

            "Mod+Shift+Left".move-column-left = _: { };
            "Mod+Shift+Right".move-column-right = _: { };
            "Mod+Shift+Up".move-window-up = _: { };
            "Mod+Shift+Down".move-window-down = _: { };

            "Mod+Ctrl+H".set-column-width = "-5%";
            "Mod+Ctrl+J".set-column-width = "+5%";
            "Mod+Ctrl+K".set-window-height = "-5%";
            "Mod+Ctrl+L".set-window-height = "+5%";

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

            "XF86Explorer".spawn-sh = "nautilus";
            "XF86Search".spawn-sh = "noctalia-shell ipc call launcher toggle";
            "XF86Calculator".spawn-sh = "qalculate-gtk";
            "XF86Tools".spawn-sh = "noctalia-shell ipc call controlCenter toggle";

            "XF86AudioMute".spawn-sh = "noctalia-shell ipc call volume muteOutput";
            "XF86AudioLowerVolume".spawn-sh = "noctalia-shell ipc call volume decrease";
            "XF86AudioRaiseVolume".spawn-sh = "noctalia-shell ipc call volume increase";
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
                  from = "#37f499";
                  to = "#808080";
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
