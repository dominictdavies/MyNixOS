{ inputs, ... }:
{
  flake.nixosModules.framework = {
    imports = [
      # Framework Laptop 13 (https://wiki.nixos.org/wiki/Hardware/Framework/Laptop_13)
      inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    ];

    # Laptop (https://wiki.nixos.org/wiki/Laptop)

    services = {
      ## Closing the lid
      logind.settings.Login = {
        HandleLidSwitch = "suspend";
        # TODO: Fix lock
        HandleLidSwitchExternalPower = "lock";
        HandleLidSwitchDocked = "ignore";
      };

      ## Enable fingerprint sensor
      fprintd.enable = true;
    };

    ## Power management
    powerManagement.enable = true;
    services.upower.enable = true;
  };
}
