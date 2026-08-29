{
  flake.nixosModules.kitty =
    { pkgs, config, ... }:
    {
      environment.systemPackages = with pkgs; [
        kitty
      ];

      systemd.user.tmpfiles.rules = [
        "L+ %h/.config/kitty/kitty.conf - - - - ${config.my.repoRoot}/dotfiles/kitty.conf"
      ];
    };
}
