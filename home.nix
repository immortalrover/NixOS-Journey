{ config, pkgs, ... }:

{
  # 设置你自己的用户名和用户目录
  home.username = "rover";
  home.homeDirectory = "/home/rover";

  # 用户级别使用的包, 如果不需要用户级别的隔离的话, 推荐全部安装到系统级别去
  home.packages = with pkgs; [
    neofetch
  ];

  # 使用home-manager的版本
  home.stateVersion = "24.11";

  # 让home-manager管理自己
  programs.home-manager.enable = true;
}
