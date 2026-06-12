{
  flake.nixosModules.common =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        fastfetch
        zip
        unzip
      ];
    };
}
