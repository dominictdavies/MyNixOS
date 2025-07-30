{ ... }:

{
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;
  networking.nameservers = [ "8.8.8.8" ];

  # Use authorised keys rather than password
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;

  # Prevent laptop from sleeping on lid close
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };
}
