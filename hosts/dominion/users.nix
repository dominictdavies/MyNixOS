{ ... }:

{
  users.users.dominictdavies = {
    isNormalUser = true;
    description = "Dominic Davies";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMbpqoIuCOeH2FjQmCdiqWsHAwKarHLW3JUIZMKsWLLB dominictdavies@domino"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDrQ8Oeq8S94OC5ifkgceryJAndoE55NnDnAF1sqJcye dominictdavies@dominator"
    ];
  };
}
