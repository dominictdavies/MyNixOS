{ inputs, ... }:
{
  flake.nixosModules.framework = {
    imports = with inputs.nixos-hardware.nixosModules; [
      # Framework Laptop 13 (https://wiki.nixos.org/wiki/Hardware/Framework/Laptop_13)
      framework-13-7040-amd
    ];

    # Laptop (https://wiki.nixos.org/wiki/Laptop)
    services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "lock";
      HandleLidSwitchDocked = "ignore";
    };
  };
}
