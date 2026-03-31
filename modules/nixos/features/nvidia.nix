{
  flake.nixosModules.nvidia = {
    # See https://wiki.nixos.org/wiki/NVIDIA
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware = {
      graphics.enable = true;
      nvidia = {
        open = true;
        modesetting.enable = true;
      };
    };
  };
}
