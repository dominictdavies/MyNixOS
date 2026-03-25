{ pkgs, ... }:

let
  backupScript = pkgs.writeShellScript "backup-neoforge-server" (
    builtins.readFile ./scripts/backup-neoforge-server.sh
  );
in
{
  systemd = {
    services = {
      neoforge-server = {
        enable = false;
        description = "NeoForge Server";
        after = [ "network.target" ];
        serviceConfig = {
          Type = "exec";
          User = "dominictdavies";
          Environment = "PATH=/run/current-system/sw/bin";
          ExecStart = "/bin/sh /home/dominictdavies/NeoForge/run.sh";
          WorkingDirectory = "/home/dominictdavies/NeoForge";
          Restart = "always";
          TimeoutStopSec = 60;
        };
        wantedBy = [ "multi-user.target" ];
      };

      neoforge-server-backup = {
        description = "NeoForge Server Backup and Restart";
        after = [ "neoforge-server.service" ];
        serviceConfig = {
          Type = "oneshot";
          User = "root";
          Environment = "PATH=/run/current-system/sw/bin";
          ExecStart = "${backupScript}";
        };
      };
    };

    timers = {
      neoforge-server-backup = {
        enable = false;
        timerConfig = {
          Persistent = true;
          OnCalendar = "*-*-* 20:00:00";
        };
        wantedBy = [ "timers.target" ];
      };
    };
  };
}
