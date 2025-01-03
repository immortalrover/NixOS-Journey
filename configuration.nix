{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  users.users.rover = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  # desktop environment / 桌面环境
  # greetd 是一个最小的、不可知的和灵活的登录管理器守护进程, 它不会假设用户想要
  # 启动什么, 应该是基于控制台的还是图形的. 任何可以从控制台启动的脚本或程序都
  # 可以通过greetd启动, 这使得它特别适合Wayland合成器. 与任何其他显示管理器一样,
  # 它还可以启动欢迎程序来启动用户会话
  # 方案1: 你可以直接启动Sway(FX)
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.swayfx}/bin/sway";
  #       user = "rover";
  #     };
  #   };
  # };
  # 方案2: 你可以通过tuigreet(一个基于控制台的登录程序)启动Sway(FX)
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # 这里写sway是正确的, 因为SwayFX实际包含的可执行文件名称没有变化
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "rover";
      };
    };
  };
  # Sway 是一个基于 Wayland 的平铺窗口管理器, 兼容 i3 配置文件, 但具备更现代化
  # 的显示协议支持. 它以简单、高效和可定制化为特点, 适合追求极简和快速操作的用户，
  # 同时提供了稳定的性能和广泛的扩展性
  programs.sway = {
    enable = true;
    # 这里使用了SwayFX, 它支持了一些毛玻璃特效
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.11";
}
