{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tmux # Terminal multiplexer
    steamcmd # Steam command-line tools
    steam-run # Run commands in the same FHS environment that is used for Steam
  ];
}
