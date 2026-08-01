{
  flake.nixosModules.common =
    { lib, ... }:
    {
      options.my.repoRoot = lib.mkOption {
        type = lib.types.str;
        default = "/home/dominictdavies/MyNixOS";
        example = "/home/alice/MyNixOS";
        description = "Absolute path to the root of MyNixOS";
      };
    };
}
