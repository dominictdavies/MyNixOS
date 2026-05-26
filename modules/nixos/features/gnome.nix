{
  flake.nixosModules.gnome =
    { pkgs, ... }:
    {
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
      ];
    };
}
