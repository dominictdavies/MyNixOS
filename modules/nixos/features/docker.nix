{ self, inputs, ... }:
{
  flake.nixosModules.docker = {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
    };
  };
}
