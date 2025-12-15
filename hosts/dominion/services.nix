{ ... }:

{
  systemd.services.neoforge-server = {
    enable = true;
    description = "NeoForge Server";
    after = [ "network.target" ];
    serviceConfig = {
      Type = "exec";
      User = "dominictdavies";
      WorkingDirectory = "/home/dominictdavies/NeoForge";
      ExecStart = "/home/dominictdavies/NeoForge/run.sh";
      Restart = "on-failure";
      TimeoutStopSec=60;
    };
    wantedBy = [ "multi-user.target" ];
  };
}
