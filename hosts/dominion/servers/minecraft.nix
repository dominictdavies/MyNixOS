{ inputs, pkgs, ... }:

{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];

  services.minecraft-servers = {
    enable = false;
    eula = true;

    servers = {
      edgetable_vegetable = {
        enable = false;
        package = pkgs.paperServers.paper;

        serverProperties = {
          level-name = "edgetable_vegetable";
          motd = "And by vegetables lets justr say edgetable";
          max-players = 7;
          level-seed = 7644964991330705060;
          difficulty = "hard";
          spawn-protection = 0;
          simulation-distance = 16;
          view-distance = 16;
          white-list = true;
          enforce-whitelist = true;
          enforce-secure-profile = false;
        };

        whitelist = {
          dominic = "d61aa5e5-2697-4b02-bc0d-164176c9169e";
          korbin = "9b47e99b-526d-4fc1-b2e1-8770ef34f7a1";
          annika = "ee4b4673-e0fe-436d-b2ae-095f2eea2ae1";
          kellen = "0de2dec5-5332-4375-9df5-83e64c665c70";
          ethan = "98bf0aab-a174-4afe-bd90-8cb5dbbae867";
          mason = "91694e45-1090-46fb-b83b-db40db0d3f48";
          chris = "63899fa9-9e5a-4a33-9a72-7510d0a79d1a";
        };

        operators = {
          dominic = "d61aa5e5-2697-4b02-bc0d-164176c9169e";
        };
      };

      nick_server = {
        enable = true;
        package = pkgs.paperServers.paper;

        serverProperties = {
          level-name = "nick_world";
          motd = "A Minecraft server";
          max-players = 2;
          difficulty = "hard";
          spawn-protection = 0;
          simulation-distance = 16;
          view-distance = 16;
          white-list = true;
          enforce-whitelist = true;
          enforce-secure-profile = false;
          allow-cheats = true;
        };

        whitelist = {
          dominic = "d61aa5e5-2697-4b02-bc0d-164176c9169e";
          nick = "58e6164a-b8a9-4c5a-8775-06e89bef2c1c";
          friend = "67ca1be4-56ad-489b-88b4-61e7866b253f";
        };

        operators = {
          dominic = "d61aa5e5-2697-4b02-bc0d-164176c9169e";
        };
      };
    };
  };
}
