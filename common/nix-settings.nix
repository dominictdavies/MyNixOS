{ ... }:

{
  nix.settings.trusted-users = [ "root" "dominictdavies" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
}
