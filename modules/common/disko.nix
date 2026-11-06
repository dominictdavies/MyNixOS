{ inputs, ... }:
{
  # Declarative disk layout (https://github.com/nix-community/disko)
  # Partitions are referenced by label rather than UUID, so this is the same on every host
  flake.nixosModules.common =
    { lib, ... }:
    {
      imports = [
        inputs.disko.nixosModules.disko
      ];

      disko.devices.disk.main = {
        type = "disk";

        # Only used when formatting (the install script passes the chosen disk)
        device = lib.mkDefault "/dev/nvme0n1";

        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0077"
                  "dmask=0077"
                ];
              };
            };

            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                settings.allowDiscards = true;

                # Only read when formatting (written by the install script)
                passwordFile = "/tmp/disko-password";

                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
}
