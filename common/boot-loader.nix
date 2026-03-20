{ ... }:

{
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 16;
  };

  boot.loader.efi.canTouchEfiVariables = true;
}
