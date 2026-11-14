{
  flake.nixosModules.common = { config, ... }: {
    # SSH (https://wiki.nixos.org/wiki/SSH)
    services.openssh = {
      enable = true;
      openFirewall = false;

      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ config.my.username ];
        MaxAuthTries = 3;
        PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
      };
    };

    # Remember key passphrases after first use (desktops use GNOME's agent instead)
    programs.ssh = {
      startAgent = !config.services.gnome.gcr-ssh-agent.enable;
      extraConfig = ''
        AddKeysToAgent yes
      '';
    };
  };
}
