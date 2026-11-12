{
  flake.nixosModules.common =
    { config, ... }:
    {
      # SSH (https://wiki.nixos.org/wiki/SSH)
      services.openssh = {
        enable = true;
        openFirewall = true;
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
