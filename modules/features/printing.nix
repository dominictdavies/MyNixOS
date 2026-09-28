{
  flake.nixosModules.printing =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bambu-studio
      ];
    };
}
