{ self, ... }:
{
  flake.nixosModules.development =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.vscodium
      ];

      environment.systemPackages = with pkgs; [
        # Programming
        devenv

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
