{ self, inputs, ... }:
{
  flake.nixosModules.desktop = {
    imports = [
      self.nixosModules.niri
      self.nixosModules.gtk
    ];

    # Make apps try to use Wayland
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = 1;
      NIXOS_OZONE_WL = 1;
      MOZ_ENABLE_WAYLAND = 1;
      GDK_BACKEND = "wayland,x11";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      SDL_VIDEODRIVER = "wayland,x11";
    };
  };
}
