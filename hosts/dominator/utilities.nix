{ ... }:

{
  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  services.printing.enable = true;
  services.fwupd.enable = true;
}
