{ ... }:

{
  networking = {
    hostName = "dominion";
    defaultGateway = "10.1.1.1";

    interfaces.eth0 = {
      useDHCP = false;
      ipv4.addresses = [ {
        address = "10.1.1.202";
        prefixLength = 24;
      } ];
    };

    firewall = {
      allowedTCPPorts = [ 443 25565 ];
      allowedUDPPorts = [ 2456 2457 25565 ];
    };
  };
}
