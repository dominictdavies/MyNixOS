{
  flake.nixosModules.common = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      fastfetch
      kitty.terminfo
      openssh
      speedtest-go
    ];
  };
}
