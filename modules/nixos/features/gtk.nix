{
  flake.nixosModules.gtk =
    {
      pkgs,
      ...
    }:
    {
      # TODO: Fix missing icons
      environment.systemPackages = with pkgs; [
        gruvbox-plus-icons
      ];
    };
}
