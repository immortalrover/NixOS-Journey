# Enable Home Manager / 启用[Home Manager](https://wiki.nixos.org/wiki/Home_Manager)

Home Manager provides user-level package management and supports a wide range
of configuration options, with cross-platform support. If you're a complete
NixOS beginner, I highly recommend starting by installing [the Standalone
version](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone),
using `home-manager switch` to manage your configuration files, and then later
integrating it into the NixOS modules.

Home Manager提供了用户级别的软件包管理，并且支持大量配置项，而且有着跨平台支持。
如果你是一个纯NixOS新手的话，非常推荐你先尝试安装Standalone版，使用
`home-manager switch`来管理你的配置文件，然后再将它一起整理进NixOS模块里面

## Possible problems / 可能出现的问题

I will switch to using the NixOS module method later, which may differ from the
Standalone version. If any issues arise, please Google the solution yourself.

之后我将使用NixOS模块的方式，可能与Standalone版不一致，遇到问题请自行Google

### error: undefined variable 'home-manager'

This is because you haven't included `home-manager` in your `outputs = {...}`.
As a result, when importing the module, it can't find where your `home-manager`
is coming from, even if you have specified its URL in the `inputs`.

这是因为你没有将`home-manager`写进你的outputs = {...}里面，所以在导入模块的时候，
找不到你的`home-manager`是哪里来的，即便你在inputs里面标明了`home-manager`的url
