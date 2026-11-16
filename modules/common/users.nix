{ my, ... }:
{
  flake.nixosModules.common = {
    users.users.${my.username} = {
      isNormalUser = true;
      description = my.fullName;
      home = my.home;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      openssh.authorizedKeys.keys = my.sshKeys;
    };
  };
}
