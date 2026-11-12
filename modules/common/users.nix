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
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGs6sDdp058I392vZxAyntIXa8BD6WvMY9fgo3jgr02s dominictdavies@domicile"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEnHTbRM2brNuuiF5XvhK3elyVnPrE/B8OK95OSWthg8 dominictdavies@dominator"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhedLya/dnqDRftrrT8P4oPKARP2WhujYFoMAZqxd7U dominictdavies@dominion"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAKmjiXmfaOPD58AE/gJQ1xltMSJsLm7wE6jV6L+UOvs nix-on-droid@localhost"
        ];
      };
    };
}
