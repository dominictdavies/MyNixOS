{
  flake.nixosModules.common =
    { config, ... }:
    {
      services = {
        cockpit = {
          enable = true;
          allowed-origins = [ "https://${config.networking.hostName}:9090" ];
        };
        fwupd.enable = true;
        tailscale.enable = true;
      };

      # Compressed swap in RAM (helps systemd-oomd under memory pressure)
      zramSwap.enable = true;
    };
}
