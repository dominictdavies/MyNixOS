{
  flake.nixosModules.common =
    { lib, ... }:
    {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };

      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          # Firmware
          "b43-firmware"
          "broadcom-bt-firmware"
          "facetimehd-firmware"
          "facetimehd-calibration"
          "xone-dongle-firmware"

          # Steam
          "steam"
          "steam-unwrapped"
        ];
    };
}
