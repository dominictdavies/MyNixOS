{
  flake.nixosModules.common = {
    services = {
      getty = {
        autologinOnce = true;
        autologinUser = "dominictdavies";
      };

      fwupd.enable = true;
    };
  };
}
