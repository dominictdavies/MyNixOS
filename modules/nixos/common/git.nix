{ self, inputs, ... }:
{
  flake.nixosModules.common = {
    environment.systemPackages = with pkgs; [
      git
      git-lfs
      git-filter-repo
    ];
  };
}
