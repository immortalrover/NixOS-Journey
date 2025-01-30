{ config, pkgs, ... }:
let
  zshPath = "${config.home.homeDirectory}/github/NixOS-Journey/zsh/zshrc";
in
{
  home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink zshPath;
}
