{
  flake.nixosModules.development =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Programming
        claude-code
        devenv
        vscode

        # Audio
        audacity

        # Image
        gimp

        # PDF
        inkscape
        poppler-utils

        # Video
        obs-studio
        shotcut

        # Game
        godot
      ];
    };
}
