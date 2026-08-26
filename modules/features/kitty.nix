{
  flake.nixosModules.kitty =
    { pkgs, config, ... }:
    {
      environment.systemPackages = with pkgs; [
        kitty
      ];

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      systemd.user.tmpfiles.rules = [
        "L+ %h/.config/kitty/kitty.conf - - - - ${config.my.repoRoot}/dotfiles/kitty.conf"
      ];
    };
}
