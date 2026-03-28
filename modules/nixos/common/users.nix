{ self, inputs, ... }:
{
  flake.nixosModules.common =
    {
      users.users.dominictdavies = {
        isNormalUser = true;
        description = "Dominic Davies";
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };
    };
}
