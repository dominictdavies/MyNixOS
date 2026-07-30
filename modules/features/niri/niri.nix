{ self, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.noctalia
      ];

      # niri (https://wiki.nixos.org/wiki/niri)
      programs.niri.enable = true;
      environment.sessionVariables.NIRI_CONFIG = "$HOME/MyNixOS/modules/features/niri/config.kdl";

      environment.systemPackages = with pkgs; [
        xwayland-satellite
        posy-cursors
      ];

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];
      };

      # GTK/Chromium apps (e.g. Steam's CEF-based UI) resolve the cursor
      # theme via GtkSettings, which without an XSETTINGS daemon falls back
      # to the conventional ~/.icons/default theme rather than XCURSOR_THEME.
      systemd.tmpfiles.rules = [
        "d /home/dominictdavies/.icons 0755 dominictdavies users -"
        "L+ /home/dominictdavies/.icons/default - - - - ${pkgs.posy-cursors}/share/icons/Posy_Cursor_Black"
      ];
    };
}
