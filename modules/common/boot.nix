{
  flake.nixosModules.common = {
    boot.loader = {
      timeout = 1;
      efi.canTouchEfiVariables = true;
      limine = {
        enable = true;
        maxGenerations = 10;
      };
    };
  };
}
