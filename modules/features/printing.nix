{
  flake.nixosModules.printing =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bambu-studio
        freecad
      ];

      # Printing (https://wiki.nixos.org/wiki/Printing)
      services = {
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };

        printing = {
          enable = true;
          drivers = with pkgs; [
            cups-filters
            cups-browsed
          ];
        };
      };
    };
}
