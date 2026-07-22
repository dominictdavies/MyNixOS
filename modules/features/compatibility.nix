{
  flake.nixosModules.compatibility =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # TODO: Move to development.nix
        devenv
        quickemu
      ];
    };
}
