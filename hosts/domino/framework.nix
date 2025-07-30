{ ... }:

{
  # Framework Laptop 13 recommendations (https://wiki.nixos.org/wiki/Hardware/Framework/Laptop_13)
  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;

  # Touchpad support
  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = false;
  };

  # Fingerprint sensor
  services.fprintd.enable = true;

  # Sound with PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
