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

    # TODO: Find a more versatile way to set up link
    systemd.tmpfiles.rules = [
      "L /etc/nixos - - - - /home/dominictdavies/MyNixOS"
    ];
  };
}
