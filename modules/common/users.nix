{
  flake.nixosModules.common =
    { config, ... }:
    {
      users.users.${config.my.username} = {
        isNormalUser = true;
        description = "Dominic Davies";
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };
    };
}
