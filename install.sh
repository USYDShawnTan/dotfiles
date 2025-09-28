#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/USYDShawnTan/dotfiles"
DOTFILES_DIR="$HOME/dotfiles"

echo "🌀 安装 Zsh 和 Git..."
if command -v apt >/dev/null; then
    # 容错：apt update 出错也不中断
    sudo apt update || true
    sudo apt install -y zsh git wget curl || true
elif command -v yum >/dev/null; then
    sudo yum install -y zsh git wget curl
else
    echo "❌ 不支持的 Linux 包管理器，请手动安装 zsh 和 git"
    exit 1
fi

if ! command -v zsh >/dev/null; then
    echo "❌ zsh 安装失败，请手动安装后再运行本脚本"
    exit 1
fi

echo "🌀 安装 Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "🌀 克隆 dotfiles 仓库..."
if [ ! -d "$DOTFILES_DIR" ]; then
    git clone "$REPO_URL" "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

echo "🌀 初始化插件/主题子模块..."
git submodule update --init --recursive

echo "🌀 复制配置文件..."
cp "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
cp "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

echo "🌀 安装插件和主题..."
mkdir -p "$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$HOME/.oh-my-zsh/custom/themes"

cp -r "$DOTFILES_DIR/oh-my-zsh-custom/plugins/"* "$HOME/.oh-my-zsh/custom/plugins/" || true
cp -r "$DOTFILES_DIR/oh-my-zsh-custom/themes/"* "$HOME/.oh-my-zsh/custom/themes/" || true

echo "✅ 完成！重启终端后即可生效。"
echo "⚠️ 别忘了在终端程序里设置字体为 MesloLGS NF"
