{ self, inputs, ... }:
{
  flake.nixosModules.framework = {
    imports = [
      # Framework Laptop 13 (https://wiki.nixos.org/wiki/Hardware/Framework/Laptop_13)
      inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    ];

    # Laptop (https://wiki.nixos.org/wiki/Laptop)

    ## Closing the lid
    services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "lock";
      HandleLidSwitchDocked = "ignore";
    };

    ## Power management
    powerManagement.enable = true;
  };
}
