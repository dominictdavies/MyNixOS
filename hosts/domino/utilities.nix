{ ... }:

{
  hardware.bluetooth.enable = true;
  services.printing.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  virtualisation.virtualbox.host.enable = true;
}
