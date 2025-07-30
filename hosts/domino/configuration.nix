{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../common/boot-loader.nix
    ../../common/environment.nix
    ../../common/locale.nix
    ../../common/nix-settings.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./users.nix
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "dominictdavies" = import ./home.nix;
    };
  };

  # Attempt to fix random GPU crashes
  boot.kernelParams = [ "amdgpu.runpm=1" ];

  # Framework recommendations (https://wiki.nixos.org/wiki/Hardware/Framework/Laptop_13)
  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support
  services.libinput.enable = true;
  services.libinput.touchpad.naturalScrolling = false;

  # Enable fingerprint sensor
  services.fprintd.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;

  # Before changing this value read the documentation (https://nixos.org/nixos/options.html)
  system.stateVersion = "24.05";
}
