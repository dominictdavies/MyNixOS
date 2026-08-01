{
  flake.nixosModules.graphics = {
    # See https://wiki.nixos.org/wiki/AMD_GPU
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
