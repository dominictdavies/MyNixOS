{
  flake.nixosModules.graphics =
    { pkgs, ... }:
    {
      # See https://wiki.nixos.org/wiki/AMD_GPU
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      environment.systemPackages = with pkgs; [
        nvtopPackages.amd
      ];

      systemd.tmpfiles.rules = [
        "L+ /opt/amdgpu/share/libdrm/amdgpu.ids - - - - ${pkgs.libdrm}/share/libdrm/amdgpu.ids"
      ];
    };
}
