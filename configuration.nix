{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 6;

  # 内核参数
  boot.kernelParams = [ "quiet" "nowatchdog" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n.defaultLocale = "en_US.UTF-8";

  # 中文输入法
  # 首次安装需要手动在fcitx5-configtool里面把Pinyin添加上才能使用中文
  # 我一般是按Ctrl + Space进行输入法的转换
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
    ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  users.users.rover = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [
    # vim
    wget
    git
    git-credential-manager
    lazygit

    # 浏览器
    firefox
    # qutebrowser 应该算是一个非常好用的纯基于键盘操作的一款浏览器
    # 推荐尝试一下, 但是遇上某些特殊情况还是用firefox会好一些:)
    qutebrowser

    # 终端仿真器
    kitty

    # 壁纸
    swaybg
    waypaper

    # 系统剪切板
    wl-clipboard

    # 文件管理器
    lf
    file # 依赖

    # Language Server
    lua-language-server
    prettierd

    # 搜索工具
    ripgrep
  ];

  # desktop environment / 桌面环境
  # greetd 是一个最小的、不可知的和灵活的登录管理器守护进程, 它不会假设用户想要
  # 启动什么, 应该是基于控制台的还是图形的. 任何可以从控制台启动的脚本或程序都
  # 可以通过greetd启动, 这使得它特别适合Wayland合成器. 与任何其他显示管理器一样,
  # 它还可以启动欢迎程序来启动用户会话
  # 方案1: 你可以直接启动Sway(FX)
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.swayfx}/bin/sway";
        user = "rover";
      };
    };
  };
  # 方案2: 你可以通过tuigreet(一个基于控制台的登录程序)启动Sway(FX)
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       # 这里写sway是正确的, 因为SwayFX实际包含的可执行文件名称没有变化
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
  #       user = "rover";
  #     };
  #   };
  # };
  # Sway 是一个基于 Wayland 的平铺窗口管理器, 兼容 i3 配置文件, 但具备更现代化
  # 的显示协议支持. 它以简单、高效和可定制化为特点, 适合追求极简和快速操作的用户，
  # 同时提供了稳定的性能和广泛的扩展性
  programs.sway = {
    enable = true;
    # 这里使用了SwayFX, 它支持了一些毛玻璃特效
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
  };

  # 代理软件
  # v2rayA 是一个V2Ray的web客户端, 默认运行在2017端口, 可以通过浏览器访问
  # localhost:2017来进入其界面, 设置非常简单且高效, 大大简化了用户操作
  services.v2raya.enable = true;

  # Font / 字体
  # 这里是一些我比较喜欢的字体
  fonts.packages = with pkgs; [
    font-awesome

    # 霞鹜文楷 + maple font 是我正在用的控制台字体
    lxgw-wenkai
    maple-mono

    # 解决字符"缺字"问题
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  # 编辑器
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    ohMyZsh.enable = true;
    ohMyZsh.theme = "kardan";
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      # 需要修改成你的nixos配置路径
      update = "sudo nixos-rebuild switch --flake ~/github/NixOS-Journey#nixos";
    };

    histFile = "$HOME/.zsh_history";
    histSize = 10000;
  };

  # nix garbage settings / nix 垃圾回收设置
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "-d";
  };

  # 节约硬盘空间
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.11";
}
