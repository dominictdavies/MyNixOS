{ ... }:

{
  networking = {
    hostName = "dominator";
    networkmanager.enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Local network file sharing
  services.samba = {
    enable = true;
  };
}
