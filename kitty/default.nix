{ config, pkgs, ... }:

{
  xdg.configFile."kitty/kitty.conf".source = ./conf;
}
