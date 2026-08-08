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

      # Auto Activation (https://devenv.sh/auto-activation/)
      programs.bash.interactiveShellInit = ''
        eval "$(devenv hook bash)"
      '';
    };
}
