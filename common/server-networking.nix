{ ... }:

{
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;
  networking.nameservers = [ "8.8.8.8" ];
}
