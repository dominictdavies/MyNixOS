{ inputs, ... }:
{
  flake.nixosModules.laptop-server = {
    imports = with inputs.nixos-hardware.nixosModules; [
      common-cpu-amd
      common-cpu-amd-pstate
      common-gpu-amd
      common-pc-laptop
    ];

    # Laptop (https://wiki.nixos.org/wiki/Laptop)
    services.logind.settings.Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
    };

    # Ethernet only, so disable the Wi-Fi and Bluetooth drivers
    boot.blacklistedKernelModules = [
      "ath10k_pci"
      "btusb"
    ];
  };
}
