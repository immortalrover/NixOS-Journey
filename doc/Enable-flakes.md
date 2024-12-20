# Enable-flakes / 启用[flakes](https://wiki.nixos.org/wiki/Flakes)

In 2024, Nix flakes is still an experimental feature, but it is truly very
useful. It allows for more customizable NixOS configurations, and it is highly
recommended to enable it.

在 2024年, Nix 中的 flakes仍是实验性特性，但是它真的是一个非常好用的特性，
能够实现更高的可自定义程度的NixOS配置，非常建议开启

## Dependencies / 依赖

`flakes` is a feature that relies heavily on `git`, so you should ensure that
`git` is installed in your system configuration file(configuration.nix).

flakes是高度依赖git的一个特性, 因此你应该保证你的系统配置文件里面安装了git

## Usage / 用法

The method to enable flakes is: / 启用flakes的方法是:

```bash
sudo nixos-rebuild --flakes .#nixos
```

---

**Note:** "nixos" is my hostname. You should replace it with your own hostname.

**注意:** nixos是我的hostname, 你应该改成你自己的hostname

---

You can check your hostname in your system configuration file or find it in the
`/etc/hostname` file.

可以在你的配置文件里查看hostname, 也可以在/etc/hostname里查看你当前的hostname

---

```bash
cat /etc/hostname
```

## Possible problems / 可能出现的问题

### error: path '/nix/store/xxx/flake.nix' does not exist

For flakes in git repos, only files in the working tree will be copied to the store(`/nix/store`).

对于 git 仓库中的flakes，只有工作区中的文件会被复制到Nix的store中

---

Therefore, if you use `git` for your flake, ensure to `git add` any project files after you first create them.

因此, 如果你在你的flake中使用`git`, 确保在你创建的任何项目文件之后你`git add`过它们

---

Solution: / 解决方法:
```bash
git add .
```
