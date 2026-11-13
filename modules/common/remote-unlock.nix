{
  flake.nixosModules.common =
    { config, ... }:
    {
      # Remote Disk Unlocking (https://wiki.nixos.org/wiki/Remote_disk_unlocking)
      boot.initrd = {
        availableKernelModules = [
          "igc"
          "r8152"
          "r8169"
        ];

        network = {
          enable = true;
          flushBeforeStage2 = true;
          ssh = {
            enable = true;
            authorizedKeys = config.users.users.${config.my.username}.openssh.authorizedKeys.keys;
            hostKeys = [ "/etc/secrets/initrd/ssh_host_ed25519_key" ];
          };
        };

        systemd = {
          network.networks."10-ethernet" = {
            matchConfig.Name = "en*";
            networkConfig.DHCP = "ipv4";
          };

          users.root.shell = "/bin/systemd-tty-ask-password-agent";
        };
      };
    };
}
