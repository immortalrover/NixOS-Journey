{ config, pkgs, ... }:

{
  xdg.configFile."pistol/pistol.conf".source = ./pistol.conf;
}
