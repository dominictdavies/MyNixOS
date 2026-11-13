{ pkgs, ... }:
{
  environment = {
    packages = with pkgs; [
      fastfetch
      git
      openssh
    ];

    # Back up existing /etc files instead of failing on the first switch
    etcBackupExtension = ".bak";
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "Australia/Perth";

  # Do not modify! (latest stateVersion nix-on-droid supports)
  system.stateVersion = "24.05";
}
