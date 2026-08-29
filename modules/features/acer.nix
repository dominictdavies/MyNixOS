{ inputs, ... }:
{
  flake.nixosModules.acer = {
    imports = [
      # Acer Laptop
      inputs.nixos-hardware.nixosModules.acer-aspire-4810t
    ];

    # Laptop (https://wiki.nixos.org/wiki/Laptop)

    ## Closing the lid
    services.logind.settings.Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
    };
  };
}
