{
  flake.nixosModules.gnome =
    { pkgs, ... }:
    {
      # Trash support (https://wiki.gnome.org/Projects/gvfs)
      services.gvfs.enable = true;

      environment.systemPackages = with pkgs; [
        # Used to edit app settings
        dconf

        # GNOME (https://apps.gnome.org/en/)
        baobab
        gnome-calculator
        gnome-characters
        gnome-connections
        gnome-disk-utility
        gnome-logs
        loupe
        nautilus
        papers
        gnome-system-monitor
        gnome-text-editor
      ];
    };
}
