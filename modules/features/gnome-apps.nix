{
  flake.nixosModules.gnome-apps = { pkgs, ... }: {
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

    xdg.mime.defaultApplications = {
      "inode/directory" = "org.gnome.Nautilus.desktop";

      "image/bmp" = "org.gnome.Loupe.desktop";
      "image/gif" = "org.gnome.Loupe.desktop";
      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/png" = "org.gnome.Loupe.desktop";
      "image/webp" = "org.gnome.Loupe.desktop";

      "application/pdf" = "org.gnome.Papers.desktop";
    };
  };
}
