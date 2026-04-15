{
  flake.nixosModules.common = {
    boot.loader = {
      timeout = 2;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
    };

    systemd.tmpfiles.rules = [
      "L /etc/nixos - - - - /home/dominictdavies/MyNixOS"
    ];
  };
}
