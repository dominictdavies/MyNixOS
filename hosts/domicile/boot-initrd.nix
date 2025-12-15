{ ... }:

{
  boot.initrd = {
    network.enable = true;

    kernelModules = [ "r8169" ];
    secrets = {
      "/etc/ssh/ssh_host_ed25519_key" = "/etc/ssh/ssh_host_ed25519_key";
    };

    network = {
      ssh = {
        enable = true;
        port = 22;
        hostKeys = [ "/etc/ssh/ssh_host_ed25519_key" ];
        authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMbpqoIuCOeH2FjQmCdiqWsHAwKarHLW3JUIZMKsWLLB dominictdavies@domino"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDrQ8Oeq8S94OC5ifkgceryJAndoE55NnDnAF1sqJcye dominictdavies@dominator"
        ];
      };

      postCommands = ''
        ip link set enp2s0f1 up
        ip addr add 10.1.1.200/24 dev enp2s0f1
        ip route add default via 10.1.1.1
        echo "nameserver 8.8.8.8" > /etc/resolv.conf
      '';
    };
  };
}
