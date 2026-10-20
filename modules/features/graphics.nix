{
  flake.nixosModules.graphics =
    { pkgs, ... }:
    {
      # See https://wiki.nixos.org/wiki/AMD_GPU
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      systemd.tmpfiles.rules = [
        "L+ /opt/amdgpu/share/libdrm/amdgpu.ids - - - - ${pkgs.libdrm}/share/libdrm/amdgpu.ids"
      ];
    };
}
