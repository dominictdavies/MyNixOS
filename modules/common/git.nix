{ my, ... }:
{
  flake.nixosModules.common = {
    programs.git = {
      enable = true;
      lfs.enable = true;

      config = {
        init.defaultBranch = "main";

        user = {
          name = my.username;
          email = my.email;
        };
      };
    };
  };
}
