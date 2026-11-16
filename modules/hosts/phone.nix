{
  inputs,
  my,
  self,
  ...
}:
{
  flake = {
    # Nix-on-Droid (https://github.com/nix-community/nix-on-droid)
    nixOnDroidConfigurations.${my.hosts.phone.name} = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
      pkgs = import inputs.nixpkgs { system = "aarch64-linux"; };
      modules = [ self.nixOnDroidModules.phone ];
    };

    nixOnDroidModules.phone = { lib, pkgs, ... }: {
      environment = {
        packages = with pkgs; [
          fastfetch
          git
          openssh
        ];

        # Back up existing /etc files instead of failing on the first switch
        etcBackupExtension = ".bak";

        # The hostname is always Android's "localhost", so hardcode it in the prompt
        sessionVariables.PS1 = ''\u@${my.hosts.phone.name}:\w\\$ '';

        # Same git identity as the NixOS hosts (modules/common/git.nix)
        etc.gitconfig.text = ''
          [init]
            defaultBranch = main
          [user]
            name = ${my.username}
            email = ${my.email}
        '';
      };

      user.userName = my.username;

      # resolv.conf is hardcoded to public DNS, so MagicDNS names don't resolve
      networking.hosts = lib.mapAttrs' (
        _: host: lib.nameValuePair host.tailscaleIp [ host.name ]
      ) my.hosts;

      nix.extraOptions = ''
        experimental-features = nix-command flakes
      '';

      time.timeZone = my.timeZone;

      # Do not modify! (latest stateVersion nix-on-droid supports)
      system.stateVersion = "24.05";
    };
  };
}
