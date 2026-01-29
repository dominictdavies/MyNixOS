{ ... }:

{
  networking.networkmanager.enable = true;
  networking.nameservers = [ "8.8.8.8" ];

  # Use authorised keys rather than password
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  # Prevent laptop from sleeping on lid close
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };
}
