{ self, ... }:
{
  flake.nixosModules.dominatorConfiguration = {
    networking.hostName = "dominator";
    imports = with self.nixosModules; [
      common
      dominatorHardware
      desktop
      coding
      gaming
    ];

    # Do not modify! (https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion)
    system.stateVersion = "26.05";
  };
}
