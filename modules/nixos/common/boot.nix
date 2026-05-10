{
  flake.nixosModules.common = {
    boot.loader = {
      timeout = 2;
      efi.canTouchEfiVariables = true;
      limine = {
        enable = true;
        maxGenerations = 10;
      };
    };
  };
}
