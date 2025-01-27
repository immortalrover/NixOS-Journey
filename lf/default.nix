{ config, pkgs, ... }:
let
  lfPath = "${config.home.homeDirectory}/github/NixOS-Journey/lf/lfrc";
in
{
  xdg.configFile."lf/lfrc".source = config.lib.file.mkOutOfStoreSymlink lfPath;
}
