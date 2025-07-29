{ inputs, ... }:

{
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "dominictdavies" = import ./home.nix;
    };
  };
}
