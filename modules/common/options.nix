{
  flake.nixosModules.common = { config, lib, ... }: {
    options.my = {
      username = lib.mkOption {
        type = lib.types.str;
        default = "dominictdavies";
        example = "alice";
        description = "Username to be used in repoRoot and elsewhere";
      };

      repoRoot = lib.mkOption {
        type = lib.types.str;
        default = "/home/${config.my.username}/MyNixOS";
        example = "/home/alice/MyNixOS";
        description = "Absolute path to the root of MyNixOS";
      };
    };
  };
}
