{
  flake.nixosModules.gnome = { pkgs, ... }: {
    # GVfs (https://wiki.gnome.org/Projects/gvfs)
    services.gvfs.enable = true;

    environment.systemPackages = with pkgs; [
      # GNOME (https://apps.gnome.org/en/)
      baobab
      gnome-calculator
      gnome-characters
      gnome-connections
      gnome-disk-utility
      gnome-logs
      gnome-system-monitor
      gnome-text-editor
      loupe
      nautilus
      papers
    ];
  };
}
