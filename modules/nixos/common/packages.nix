{
  flake.nixosModules.common =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        fastfetch
        git
        git-lfs
        git-filter-repo
        stress-ng
      ];
    };
}
