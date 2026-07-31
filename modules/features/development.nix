{
  flake.nixosModules.development =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Programming
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
