{
  flake.nixosModules.common = {
    services = {
      cockpit.enable = true;
      fwupd.enable = true;
      tailscale.enable = true;
    };

    # Compressed swap in RAM (helps systemd-oomd under memory pressure)
    zramSwap.enable = true;
  };
}
