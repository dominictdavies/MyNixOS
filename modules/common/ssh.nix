{
  flake.nixosModules.common =
    { config, ... }:
    {
      # SSH (https://wiki.nixos.org/wiki/SSH)
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 22 ];

      services.openssh = {
        enable = true;
        openFirewall = false;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "no";
          AllowUsers = [ "${config.my.username}" ];
          MaxAuthTries = 3;
          PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
        };
      };
    };
}
