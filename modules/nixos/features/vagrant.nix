{ self, inputs, ... }:
{
  flake.nixosModules.vagrant = {
    environment.systemPackages = with pkgs; [
      vagrant
    ];

    virtualisation.virtualbox.host.enable = true;
  };
}
