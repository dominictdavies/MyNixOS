{
  flake.nixosModules.common =
    { config, ... }:
    {
      boot.loader = {
        timeout = 2;
        efi.canTouchEfiVariables = true;
        limine = {
          enable = true;
          maxGenerations = 10;

          # Also install Limine at the firmware's fallback path
          extraInstallCommands = ''
            install -D ${config.boot.loader.efi.efiSysMountPoint}/EFI/limine/BOOTX64.EFI \
              ${config.boot.loader.efi.efiSysMountPoint}/EFI/BOOT/BOOTX64.EFI
          '';
        };
      };
    };
}
