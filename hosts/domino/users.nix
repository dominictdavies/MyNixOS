{ ... }:

{
  users.users.dominictdavies = {
    isNormalUser = true;
    description = "Dominic Davies";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker" # Allows running docker without sudo
    ];
    # hashedPassword = "*";
  };
}
