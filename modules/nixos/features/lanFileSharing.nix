{ self, inputs, ... }:
{
  flake.nixosModules.lanFileSharing = {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    services.samba.enable = true;
    services.samba-wsdd.enable = true;
  };
}
