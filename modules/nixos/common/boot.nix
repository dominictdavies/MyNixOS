{
  flake.nixosModules.common = {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };

      timeout = 1;
    };
  };
}
