{ ... }:

{
  networking = {
    hostName = "domicile";
    defaultGateway = "10.1.1.1";

    interfaces.enp2s0f1 = {
      useDHCP = false;
      ipv4.addresses = [ {
        address = "10.1.1.200";
        prefixLength = 24;
      } ];
    };

    firewall = {
      allowedTCPPorts = [ 22 ];
    };
  };
}
