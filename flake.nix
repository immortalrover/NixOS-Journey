{
  description = "My NixOS flake";

  inputs = {
    # NixOS 官方软件源，这里使用 nixos-24.11 分支
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    # home-manager 用于管理用户级的配置
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  # 注意outputs里面要添加home-manager
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # TODO: 请将下面的`nixos`替换成你的 hostname, 我自己的主机是习惯直接使用
    # nixos作为我的主机名字
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # 这里导入之前我们使用的 configuration.nix，
        # 这样旧的配置文件仍然能生效
        ./configuration.nix

        # home-manager 以模块的方式导入
        home-manager.nixosModules.home-manager {
          # 除非需要严格的系统包和用户包隔离, 否则建议将两个都设置为true
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # 这里设置你自己的用户名,以及你可以设置你的home.nix的路径, 你可以尝试
          # 在这里分文件. 不过这里的路径一定是相对路径, 且不能使用../引用工作目
          # 录之外的路径
          home-manager.users.rover = import ./home.nix;
        }
      ];
    };
  };

  nixConfig = {
    # 添加清华大学开源软件镜像源
    trusted-substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    ];
  };
}
