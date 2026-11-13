{
  flake.nixosModules.common =
    { config, ... }:
    {
      services = {
        cockpit = {
          enable = true;
          allowed-origins = [ "https://${config.networking.hostName}.tailefeb39.ts.net" ];
        };
        fwupd.enable = true;
        tailscale.enable = true;
      };

      # Compressed swap in RAM (helps systemd-oomd under memory pressure)
      zramSwap.enable = true;
    };
}
