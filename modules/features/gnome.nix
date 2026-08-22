{
  flake.nixosModules.gnome =
    { pkgs, ... }:
    {
      # Trash support (https://wiki.gnome.org/Projects/gvfs)
      services.gvfs.enable = true;

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
        snapshot
        gnome-system-monitor
        gnome-text-editor
      ];
    };
}
