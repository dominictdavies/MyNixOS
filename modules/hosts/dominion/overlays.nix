{ inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
    inputs.nix-tmodloader.overlay
  ];
}
