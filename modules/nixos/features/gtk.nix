{ self, ... }:
{
  flake.nixosModules.gtk =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.xdg
      ];

      environment.systemPackages = with pkgs; [
        gruvbox-plus-icons
      ];

      programs.dconf = {
        enable = true;
        profiles.user.databases = [
          {
            settings."org/gnome/desktop/interface" = {
              gtk-theme = "Gruvbox-Green-Dark-Medium";
              icon-theme = "Gruvbox-Plus-Dark";
              color-scheme = "prefer-dark";
            };
          }
        ];
      };
    };
}
