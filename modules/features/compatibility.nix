{
  flake.nixosModules.compatibility =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        quickemu
      ];
    };
}
