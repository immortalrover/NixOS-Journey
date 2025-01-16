{ config, pkgs, ... }:
let
  # 必须要用绝对路径, 这里的`${config.home.homeDirectory}`相当于是用户家目录
  nvimPath = "${config.home.homeDirectory}/github/NixOS-Journey/nvim/config";
in
{
  xdg.configFile."nvim" = {
    # mkOutOfStoreSymlink让你的更改能够立即生效, 而不需要等待nixos-rebuild 去
    # 重新switch了.
    # 注: 使用mkOutOfStoreSymlink函数必须要使用绝对路径
    source = config.lib.file.mkOutOfStoreSymlink nvimPath;
    recursive = true;
  };
}
