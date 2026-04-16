{
  flake.nixosModules.compatibility =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        unzip
        wineWow64Packages.stable
      ];
    };
}
