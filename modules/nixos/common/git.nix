{
  flake.nixosModules.common =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        git
        git-lfs
        git-filter-repo
      ];
    };
}
