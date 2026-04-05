{
  flake.nixosModules.vagrant =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.vagrant
      ];

      virtualisation.virtualbox.host.enable = true;
    };
}
