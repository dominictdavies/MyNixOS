{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../common/boot-loader.nix
    ../../common/environment.nix
    ../../common/locale.nix
    ../../common/nix-settings.nix
    ../../common/laptop-server.nix
    ./hardware-configuration.nix
    ./overlays.nix
    ./networking.nix
    ./nginx.nix
    ./grafana-and-prometheus.nix
    ./server-minecraft.nix
    ./server-tmodloader.nix
    ./server-valheim.nix
    ./backups.nix
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "dominictdavies" = import ./home.nix;
    };
  };

  # Define a user account
  users.users.dominictdavies = {
    isNormalUser = true;
    description = "Dominic Davies";
    extraGroups = [ "networkmanager" "wheel" ];
    # hashedPassword = "*";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMbpqoIuCOeH2FjQmCdiqWsHAwKarHLW3JUIZMKsWLLB dominictdavies@gmail.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYWWLuj8iaTVE/2TQbXhosNCzQcRB+RhMvnPHcXfgxrH4XqpF0we5xF1tC94zFDzzn3VwYkQpL2kKSdtSVNCyGfywPIOZpSQc5zuiNfc50uajN+XBkECYdVgdiJLRPOwCIECyTllSyJUmA+KKjjNzKOGLCmBCkVhZ6XiJ1+ErxUzYy5PXYZip3N2OiIgS3nACtqpHe2Jo9bvP6kZi9QxpWa87C0M7zW65uHKDYusJxKlYe2fKBF6jfHniMN0ZuQvWaoZ3y4lGp5mlQf2QtUdNgm9197LpHsSWVAidbxVTa+2yDNpJv33rnOcAmhpSrfOrGNzOaqmObkCde8HCTsopg9YFT3ixmDRjMltd/+YfY+j/3BT331lRIBD1uDysQYb6+84LVdq9HnEQ6DzX69C2ZmX1koE9pCTq84KGzK6WReE6rf4AK0JXmnE23dTRV4GDnNIPW/y4nl+8XWRS6kusvVtACd6/shU48YjQke5Yxuf2JDMvUb2LMPUZQvRo4zgMd5Vmen9eutK599GrPbZsKh7Rm9jnSR+xHr7s7umYbPmTSe14t5Ka73uf80nj0SFRersKDxzZbPlIN9eUy8g6SajTXzGKiWdOBMP5hSCLpyOd26toWl3NW7hUrPrg4XTJbxxNKG33glYkrS6SAZF7mXrr3PLYavk/iwxPyVs8NOQ== dominictdavies@dominator"
    ];
    packages = with pkgs; [];
  };

  # Before changing this value read the documentation (https://nixos.org/nixos/options.html)
  system.stateVersion = "24.05";
}
