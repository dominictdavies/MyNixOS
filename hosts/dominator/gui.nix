{ ... }:

{
  # NVIDIA Graphics (https://wiki.nixos.org/wiki/NVIDIA)
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    graphics.enable = true;

    nvidia = {
      open = true;
      modesetting.enable = true;
    };
  };

  # KDE Plasma Desktop Environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
}
