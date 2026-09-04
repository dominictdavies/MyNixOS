{
  flake.nixosModules.common = {
    boot.loader = {
      timeout = 3;
      efi.canTouchEfiVariables = true;
      limine = {
        enable = true;
        maxGenerations = 10;
      };
    };
  };
}
