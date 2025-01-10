{ config, pkgs, ... }:

{
  xdg.configFile."git/config".source = ./config;
}
