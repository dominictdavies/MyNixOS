{
  flake.nixosModules.common =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        fastfetch
        openssh
        speedtest-go
      ];
    };
}
