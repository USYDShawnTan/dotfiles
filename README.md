# 🌀 Dotfiles for Zsh + Oh My Zsh + Powerlevel10k

这是我的 Zsh 配置仓库，包含：

- `.zshrc`
- `.p10k.zsh`（Powerlevel10k 主题配置）
- Oh My Zsh 插件 & 主题（通过 Git Submodule 管理）

⚡ 特点：

- 一行命令即可完成安装
- 无需手动运行 `p10k configure`，主题配置直接随 `.p10k.zsh` 生效
- 使用 `cp`，不依赖软链接，简单可靠

---

## 🚀 一行命令安装

在新机器上直接运行：

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/USYDShawnTan/dotfiles/main/install.sh)
```

## 更新插件

```bash
cd ~/dotfiles
git submodule update --remote --merge
git commit -am "update plugins"
git push
```

## 备份更新配置

当你修改了 .zshrc 或 .p10k.zsh 时：

```bash
cp ~/.zshrc ~/dotfiles/
cp ~/.p10k.zsh ~/dotfiles/

cd ~/dotfiles
git add .
git commit -m "update zsh config"
git push
```

## 🌀 新插件的安装流程

1. 添加 Submodule

假设你要装 zsh-completions

```bash

cd ~/dotfiles

git submodule add https://github.com/zsh-users/zsh-completions.git oh-my-zsh-custom/plugins/zsh-completions
git commit -m "add zsh-completions plugin"
git push
```

这样仓库就会记录这个插件。

2. 修改 .zshrc 激活插件

在 .zshrc 的 plugins=(...) 里加上新插件，比如：

```bash
vim ~/dotfiles/.zshrc
```

```bash
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions   # 新插件
)
```

然后同步到仓库：

```bash
cp ~/.zshrc ~/dotfiles/
cd ~/dotfiles
git add .zshrc
git commit -m "enable zsh-completions plugin"
git push
```

🌀 在新机器上恢复
当你在新机器上跑 install.sh 时，submodule 会自动把插件克隆到 ~/dotfiles/oh-my-zsh-custom/plugins/，脚本又会 cp 到 ~/.oh-my-zsh/custom/plugins/，所以新插件也会生效。
