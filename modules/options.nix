{ config, lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  # Personal values shared by every host, available to all modules as `my`
  options.my = {
    username = mkOption {
      type = types.str;
      default = "dominictdavies";
      example = "alice";
      description = "Name of the user account on every host";
    };

    fullName = mkOption {
      type = types.str;
      default = "Dominic Davies";
      example = "Alice Smith";
      description = "Full name of the user";
    };

    email = mkOption {
      type = types.str;
      default = "dominictdavies@gmail.com";
      example = "alice@example.com";
      description = "Email address of the user, used for git commits";
    };

    home = mkOption {
      type = types.str;
      default = "/home/${config.my.username}";
      example = "/home/alice";
      description = "Home directory of the user";
    };

    repo = mkOption {
      type = types.str;
      default = "dominictdavies/MyNixOS";
      example = "alice/MyNixOS";
      description = "GitHub repository holding this configuration";
    };

    repoRoot = mkOption {
      type = types.str;
      default = "${config.my.home}/${baseNameOf config.my.repo}";
      example = "/home/alice/MyNixOS";
      description = "Absolute path to the local clone of the repository";
    };

    timeZone = mkOption {
      type = types.str;
      default = "Australia/Perth";
      example = "Europe/London";
      description = "Time zone of every host";
    };

    locale = mkOption {
      type = types.str;
      default = "en_AU.UTF-8";
      example = "en_GB.UTF-8";
      description = "Default locale of every host";
    };

    tailnet = mkOption {
      type = types.str;
      default = "tailefeb39.ts.net";
      example = "tail1a2b3c.ts.net";
      description = "Domain of the Tailscale tailnet, used for HTTPS addresses";
    };

    sshKeys = mkOption {
      type = types.listOf types.str;
      default = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGs6sDdp058I392vZxAyntIXa8BD6WvMY9fgo3jgr02s dominictdavies@domicile"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEnHTbRM2brNuuiF5XvhK3elyVnPrE/B8OK95OSWthg8 dominictdavies@dominator"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhedLya/dnqDRftrrT8P4oPKARP2WhujYFoMAZqxd7U dominictdavies@dominion"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAKmjiXmfaOPD58AE/gJQ1xltMSJsLm7wE6jV6L+UOvs dominictdavies@domino"
      ];
      description = "Public SSH keys allowed to log in to every host";
    };

    storage = {
      pool = mkOption {
        type = types.str;
        default = "terra";
        example = "tank";
        description = "Name of the ZFS pool on the server";
      };

      mountPoint = mkOption {
        type = types.str;
        default = "/mnt/${config.my.storage.pool}";
        example = "/mnt/tank";
        description = "Where the pool's data is mounted on the server and shared over NFS";
      };

      backups = mkOption {
        type = types.str;
        default = "${config.my.storage.mountPoint}/Backups";
        example = "/mnt/tank/Backups";
        description = "Directory holding the server's backups";
      };
    };

    hosts = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            name = mkOption {
              type = types.str;
              description = "Hostname of the host";
            };

            tailscaleIp = mkOption {
              type = types.str;
              description = "Tailscale IP address of the host";
            };

            syncthingId = mkOption {
              type = types.nullOr types.str;
              default = null;
              description = "Syncthing device ID of the host";
            };
          };
        }
      );

      default = {
        server = {
          name = "domicile";
          tailscaleIp = "100.65.68.2";
        };

        computer = {
          name = "dominator";
          tailscaleIp = "100.98.63.45";
        };

        laptop = {
          name = "dominion";
          tailscaleIp = "100.70.165.74";
        };

        phone = {
          name = "domino";
          tailscaleIp = "100.89.21.70";
          syncthingId = "XMBWKYF-ARGGKN7-NGCJP2I-P7JS4NA-G2LNKQ2-CY5RCFK-QIZSGVK-YXLGSA6";
        };
      };

      description = "The four hosts, by role";
    };
  };

  config._module.args.my = config.my;
}
