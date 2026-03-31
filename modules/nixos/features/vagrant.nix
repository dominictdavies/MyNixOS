{
  flake.nixosModules.vagrant =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        vagrant
      ];

      virtualisation.virtualbox.host.enable = true;
    };
}
