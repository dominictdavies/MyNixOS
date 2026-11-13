{
  flake.nixOnDroidModules.domino =
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

        # The hostname is always Android's "localhost", so hardcode it in the prompt
        sessionVariables.PS1 = ''\u@domino:\w\\$ '';
      };

      user.userName = "dominictdavies";

      # resolv.conf is hardcoded to public DNS, so MagicDNS names don't resolve
      networking.hosts = {
        "100.65.68.2" = [ "domicile" ];
        "100.98.63.45" = [ "dominator" ];
      };

      nix.extraOptions = ''
        experimental-features = nix-command flakes
      '';

      time.timeZone = "Australia/Perth";

      # Do not modify! (latest stateVersion nix-on-droid supports)
      system.stateVersion = "24.05";
    };
}
