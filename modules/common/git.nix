{
  flake.nixosModules.common = { config, ... }: {
    programs.git = {
      enable = true;
      lfs.enable = true;

      config = {
        init.defaultBranch = "main";

        user = {
          name = config.my.username;
          email = "dominictdavies@gmail.com";
        };
      };
    };
  };
}
