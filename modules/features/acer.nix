{ inputs, ... }:
{
  flake.nixosModules.acer = {
    imports = with inputs.nixos-hardware.nixosModules; [
      common-cpu-intel
      common-pc-laptop
    ];

    # Laptop (https://wiki.nixos.org/wiki/Laptop)
    services.logind.settings.Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
    };
  };
}
