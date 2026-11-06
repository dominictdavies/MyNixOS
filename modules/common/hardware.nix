{
  # Hardware support shared by all hosts (replaces per-host `nixos-generate-config` output)
  # Disk layout is in disko.nix, host-specific hardware is imported in each host's file in hosts/
  flake.nixosModules.common =
    { config, modulesPath, ... }:
    {
      imports = [
        # Enables redistributable firmware (Wi-Fi, Bluetooth, GPU, etc.)
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      nixpkgs.hostPlatform = "x86_64-linux";

      # Drivers needed to reach the root disk at boot (only loaded if the hardware is present)
      boot.initrd.availableKernelModules = [
        # Disk controllers
        "ahci"
        "nvme"
        "sd_mod"

        # SD card readers
        "rtsx_pci_sdmmc"
        "sdhci_pci"

        # USB, Thunderbolt, and keyboards (for typing the LUKS passphrase)
        "thunderbolt"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];

      # Only the microcode matching the CPU is applied
      hardware.cpu = {
        amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
        intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
      };
    };
}
