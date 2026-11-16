{ my, ... }:
{
  flake.nixosModules.kitty = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ kitty ];

    systemd.user.tmpfiles.rules = [
      "L+ %h/.config/kitty/kitty.conf - - - - ${my.repoRoot}/dotfiles/kitty.conf"
    ];
  };
}
