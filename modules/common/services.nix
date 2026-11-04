{
  flake.nixosModules.common = {
    services.fwupd.enable = true;

    # Compressed swap in RAM (helps systemd-oomd under memory pressure)
    zramSwap.enable = true;
  };
}
