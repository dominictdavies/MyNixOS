{
  flake.nixosModules.common =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        claude-code
        fastfetch
        zip
        unzip
      ];
    };
}
