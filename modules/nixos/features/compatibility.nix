{
  flake.nixosModules.compatibility =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        zip
        unzip
        wineWow64Packages.stable
        quickgui
      ];
    };
}
