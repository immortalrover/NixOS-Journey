{ config, pkgs, ... }:
let
  lfPath = "${config.home.homeDirectory}/github/NixOS-Journey/lf/config";
in
{
  xdg.configFile."lf" = {
    source = config.lib.file.mkOutOfStoreSymlink lfPath;
    recursive = true;
  };
}
