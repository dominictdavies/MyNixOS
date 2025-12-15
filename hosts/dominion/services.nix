{ ... }:

{
  systemd.services.neoforge-server = {
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
}
