{ inputs, ... }:

{
  imports = [ inputs.nix-tmodloader.nixosModules.tmodloader ];

  services.tmodloader = {
    enable = true;

    servers = {
      third_calamity = {
        enable = true;
        openFirewall = true;
        noupnp = true;
        players = 6;
        world = "/var/lib/tmodloader/third_calamity/Worlds/Winners_Only.wld";
        password = "afflicted wind parmesan";
        install = [
          2824688072 # Calamity Mod
          2824688266 # Calamity Mod Music
          2687866031 # Census - Town NPC Checklist
          2599842771 # AlchemistNPC Lite
          2565540604 # Auto Trash
          2838188064 # Basic Automated (Vein) Mining
          2818817085 # Better Respawn
          2669644269 # Boss Checklist
          2816694149 # Boss Cursor
          3241967932 # Calamity: Hunt of the Old God
          2824688804 # Calamity's Vanities
          2838015851 # Catalyst Mod
          2835214226 # Calamity Mod Extra Music
          2570931073 # Fargo's Mutant Mod
          3222493606 # Luminance
          2815540735 # Fargo's Souls Mod
          2785100219 # Subworld Library
          3044249615 # Calamity - Fargo's Souls DLC
          2782337219 # Fargo's Music Mod
          2670628346 # Lights And Shadows
          2908170107 # absoluteAquarian Utilities (SerousCommonLib)
          2563309347 # Magic Storage
          2562915378 # Max Stack Plus Extra
          2831752947 # LuiAFK Reborn
          2812377597 # No Pylon Restrictions
          3172916251 # Realistic Sky
          2619954303 # Recipe Browser
          2597324266 # Wing Slot Extra
          3092612587 # Revive Mod
          3101940607 # Boss Leaderboards
          3098311063 # Projectiles Be Gone
        ];
      };
    };
  };
}
