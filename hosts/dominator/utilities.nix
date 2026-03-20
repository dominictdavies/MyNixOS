{ ... }:

{
  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  services.fwupd.enable = true;
  services.ratbagd.enable = true;
  services.printing.enable = true;
}
