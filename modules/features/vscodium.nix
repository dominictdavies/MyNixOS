{
  flake.nixosModules.vscodium =
    { pkgs, config, ... }:
    {
      environment.systemPackages = with pkgs; [
        vscodium
      ];

      systemd.user.tmpfiles.rules = [
        "L+ %h/.config/VSCodium/User/settings.json - - - - ${config.my.repoRoot}/dotfiles/vscodium/settings.json"
        "L+ %h/.config/VSCodium/User/keybindings.json - - - - ${config.my.repoRoot}/dotfiles/vscodium/keybindings.json"
      ];
    };
}
