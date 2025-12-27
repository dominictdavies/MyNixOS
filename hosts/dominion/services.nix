{ ... }:

{
  systemd = {
    services = {
      neoforge-server = {
        enable = true;
        description = "NeoForge Server";
        after = [ "network.target" ];
        serviceConfig = {
          Type = "exec";
          User = "dominictdavies";
          Environment = "PATH=/run/current-system/sw/bin";
          ExecStart = "/bin/sh /home/dominictdavies/NeoForge/run.sh";
          WorkingDirectory = "/home/dominictdavies/NeoForge";
          Restart = "on-failure";
          TimeoutStopSec=60;
        };
        wantedBy = [ "multi-user.target" ];
      };

      neoforge-server-backup = {
        enable = true;
        description = "NeoForge Server Backup and Restart";
        after = [ "neoforge-server.service" ];
        serviceConfig = {
          Type = "oneshot";
          User = "root";
          Environment = "PATH=/run/current-system/sw/bin";
          ExecStart = "/bin/sh -c 'systemctl stop neoforge-server && tar -czf /home/dominictdavies/Backups/world-ours/world-ours_$(date +\\%Y-\\%m-\\%d).tar.gz /home/dominictdavies/NeoForge/world-ours/ && chown dominictdavies:dominictdavies /home/dominictdavies/Backups/world-ours/world-ours_$(date +\\%Y-\\%m-\\%d).tar.gz; systemctl start neoforge-server'";
        };
      };
    };

    timers = {
      neoforge-server-backup-timer = {
        timerConfig = {
          Persistent = true;
          OnCalendar = "*-*-* 22:00:00";
        };
        wantedBy = [ "timers.target" ];
      };
    };
  };
}
