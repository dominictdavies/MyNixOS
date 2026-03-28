{
  flake.nixosModules.gtk =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        gruvbox-plus-icons
      ];
    };
}
