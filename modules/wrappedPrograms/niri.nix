{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };

      environment.systemPackages = with pkgs; [
        kitty
        scrcpy
        nautilus
        qalculate-gtk  # TODO: Get qalculate to find dark mode
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

          # Outputs (https://github.com/niri-wm/niri/wiki/Configuration:-Outputs)
          outputs = {
            HDMI-A-1 = {
              mode = "2560x1080@60.000";
              position._attrs = {
                x = 0;
                y = 360;
              };
            };
            DP-1 = {
              mode = "2560x1440@143.972";
              position._attrs = {
                x = 2560;
                y = 0;
              };
            };
          };

          # Key Bindings (https://github.com/niri-wm/niri/wiki/Configuration:-Key-Bindings)
          binds = {
            "Mod+Shift+Slash".show-hotkey-overlay = null;

            "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
            "Mod+P".spawn-sh = lib.getExe pkgs.scrcpy;

            "Mod+Q".close-window = null;
            "Mod+F".maximize-column = null;
            "Mod+Shift+F".toggle-window-floating = null;
            "Mod+G".fullscreen-window = null;
            "Mod+C".center-column = null;

            "Mod+Left".focus-column-left = null;
            "Mod+Right".focus-column-right = null;
            "Mod+Up".focus-window-up = null;
            "Mod+Down".focus-window-down = null;

            "Mod+WheelScrollDown".focus-column-left = null;
            "Mod+WheelScrollUp".focus-column-right = null;
            "Mod+Ctrl+WheelScrollDown".focus-workspace-down = null;
            "Mod+Ctrl+WheelScrollUp".focus-workspace-up = null;

            "Mod+Shift+Left".move-column-left = null;
            "Mod+Shift+Right".move-column-right = null;
            "Mod+Shift+Up".move-window-up = null;
            "Mod+Shift+Down".move-window-down = null;

            "Mod+Ctrl+H".set-column-width = "-5%";
            "Mod+Ctrl+J".set-column-width = "+5%";
            "Mod+Ctrl+K".set-window-height = "-5%";
            "Mod+Ctrl+L".set-window-height = "+5%";

            # TODO: Fix workspace keybinds (not working currently)
            "Mod+1".focus-workspace = "w0";
            "Mod+2".focus-workspace = "w1";
            "Mod+3".focus-workspace = "w2";
            "Mod+4".focus-workspace = "w3";
            "Mod+5".focus-workspace = "w4";
            "Mod+6".focus-workspace = "w5";
            "Mod+7".focus-workspace = "w6";
            "Mod+8".focus-workspace = "w7";
            "Mod+9".focus-workspace = "w8";
            "Mod+0".focus-workspace = "w9";

            "Mod+Shift+1".move-column-to-workspace = "w0";
            "Mod+Shift+2".move-column-to-workspace = "w1";
            "Mod+Shift+3".move-column-to-workspace = "w2";
            "Mod+Shift+4".move-column-to-workspace = "w3";
            "Mod+Shift+5".move-column-to-workspace = "w4";
            "Mod+Shift+6".move-column-to-workspace = "w5";
            "Mod+Shift+7".move-column-to-workspace = "w6";
            "Mod+Shift+8".move-column-to-workspace = "w7";
            "Mod+Shift+9".move-column-to-workspace = "w8";
            "Mod+Shift+0".move-column-to-workspace = "w9";

            # TODO: Shorten ${lib.getExe self'.packages.myNoctalia}
            "XF86Explorer".spawn-sh = lib.getExe pkgs.nautilus;
            "XF86Search".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
            "XF86Calculator".spawn-sh = lib.getExe pkgs.qalculate-gtk;
            "XF86Tools".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call controlCenter toggle";

            "XF86AudioMute".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call volume muteOutput";
            "XF86AudioLowerVolume".spawn-sh =
              "${lib.getExe self'.packages.myNoctalia} ipc call volume decrease";
            "XF86AudioRaiseVolume".spawn-sh =
              "${lib.getExe self'.packages.myNoctalia} ipc call volume increase";
          };

          # Layout (https://github.com/niri-wm/niri/wiki/Configuration:-Layout)
          layout = {
            gaps = 16;
            focus-ring = {
              width = 8;
              active-gradient._attrs = {
                from = "#37f499";
                to = "#04d1f9";
                angle = 45;
              };

              inactive-gradient._attrs = {
                from = "#37f499";
                to = "#808080";
                angle = 45;
              };
            };
          };

          # Miscellaneous (https://github.com/niri-wm/niri/wiki/Configuration:-Miscellaneous)
          cursor = {
            xcursor-theme = "Posy_Cursor_Black";
            xcursor-size = 48;
          };
          hotkey-overlay = { # TODO: Remove unbound binds from overlay
            skip-at-startup = null;
          };

        };
      };
    };
}
