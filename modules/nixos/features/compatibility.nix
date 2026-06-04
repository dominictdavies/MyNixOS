{
  flake.nixosModules.compatibility =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        zip
        unzip
        quickemu
      ];
    };
}
