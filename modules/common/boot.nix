{
  flake.nixosModules.common = {
    boot = {
      loader = {
        timeout = 3;
        efi.canTouchEfiVariables = true;
        limine = {
          enable = true;
          maxGenerations = 10;
        };
      };

      # Setup RAID
      swraid.enable = true;
      extraModprobeConfig = ''
        options usbcore autosuspend=-1
      '';
    };
  };
}
