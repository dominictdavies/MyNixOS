{
  flake.nixosModules.development =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Programming
        claude-code
        devenv
        vscodium

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
