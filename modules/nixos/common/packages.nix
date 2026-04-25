{
  flake.nixosModules.common =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nixfmt
        fastfetch
        stress-ng
      ];
    };
}
