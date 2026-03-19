{ ... }:

{
  # X11 windowing system with NVIDIA card
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
  };

  # KDE Plasma Desktop Environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
}
