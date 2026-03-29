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

      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };
    };
}
