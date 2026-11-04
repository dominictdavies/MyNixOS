{
  flake.nixosModules.common =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        fastfetch
        speedtest-go
        zip
        unzip
      ];
    };
}
