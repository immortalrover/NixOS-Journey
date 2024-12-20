{
  description = "My NixOS flake";

  inputs = {
    # NixOS 官方软件源，这里使用 nixos-24.11 分支
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # TODO: 请将下面的`nixos`替换成你的 hostname, 我自己的主机是习惯直接使用
    # nixos作为我的主机名字
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # 这里导入之前我们使用的 configuration.nix，
        # 这样旧的配置文件仍然能生效
        ./configuration.nix
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
