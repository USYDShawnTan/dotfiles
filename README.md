好嘞 👍 我帮你写一个 `README.md`，专门说明你的 **dotfiles 仓库**后续怎么恢复环境、怎么更新（备份）配置。你可以直接放到 `dotfiles` 仓库里。

---

# README.md (示例内容)

````markdown
# 🌀 My Dotfiles (Zsh + Oh My Zsh)

这里存放我的 Zsh / Oh My Zsh 配置，包括：
- `.zshrc`  
- `.p10k.zsh` (Powerlevel10k 主题配置)  
- 自定义插件 / 主题（用 git submodule 管理）  

---

## 🚀 新机器恢复步骤

1. **安装 Zsh**
   ```bash
   sudo apt install zsh -y   # Ubuntu/Debian
   chsh -s $(which zsh)      # 设置 zsh 为默认 shell
````

2. **安装 Oh My Zsh**

   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

3. **克隆本仓库**

   ```bash
   git clone git@github.com:USYDShawnTan/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

4. **初始化子模块（插件和主题）**

   ```bash
   git submodule update --init --recursive
   ```

5. **链接配置文件**

   ```bash
   ln -sf ~/dotfiles/.zshrc ~/.zshrc
   ln -sf ~/dotfiles/.p10k.zsh ~/.p10k.zsh
   ```

6. **复制自定义插件/主题**

   ```bash
   cp -r ~/dotfiles/oh-my-zsh-custom ~/.oh-my-zsh/custom
   ```

7. **重新打开终端 🎉**

---

## 📦 下一次备份 / 更新

1. 确认改动（比如 `.zshrc` 新增了插件）：

   ```bash
   git status
   ```

2. 提交改动：

   ```bash
   git add .
   git commit -m "update zsh config"
   git push
   ```

---

## 🔄 更新插件/主题 (Submodules)

拉取最新插件：

```bash
git submodule update --remote --merge
git commit -am "update plugins"
git push
```

---


## 💡 未来改进想法

* 用 [GNU Stow](https://www.gnu.org/software/stow/) 管理 dotfiles，恢复时更优雅。
* 用 GitHub Actions 自动定期 push 历史命令。


啊，这个问题问得好 ✅ ——因为你用 **submodule** 管理插件，所以「新安装插件」就要分情况了：

---

## 🌀 情况 1：插件本身是一个 Git 仓库（99% 的情况）

比如 `zsh-autosuggestions`、`zsh-syntax-highlighting` 这种。
安装方式不是直接 `git clone`，而是加 submodule：

```bash
cd ~/dotfiles

# 新插件，比如 fast-syntax-highlighting
git submodule add https://github.com/zdharma-continuum/fast-syntax-highlighting.git oh-my-zsh-custom/plugins/fast-syntax-highlighting

# 提交
git add .gitmodules oh-my-zsh-custom/plugins/fast-syntax-highlighting
git commit -m "add fast-syntax-highlighting plugin"
git push
```

以后恢复环境时，跑：

```bash
git submodule update --init --recursive
```

就能把新插件拉下来。

---

## 🌀 情况 2：插件不是 Git 仓库（很少见）

比如你自己写了个 `myplugin.zsh` 文件，直接丢到 custom 目录。
这种直接当普通文件管理：

```bash
cp myplugin.zsh ~/dotfiles/oh-my-zsh-custom/plugins/myplugin/myplugin.plugin.zsh

cd ~/dotfiles
git add .
git commit -m "add my custom plugin"
git push
```

恢复时，它会直接被复制回来。

---

## 🌀 `.zshrc` 的修改

别忘了在 `~/.zshrc` 里加上插件名字：

```zsh
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)
```

改完之后：

```bash
cd ~/dotfiles
git add .zshrc
git commit -m "enable fast-syntax-highlighting plugin"
git push
```

---

## ✅ 最终流程总结（新插件）

1. **submodule 插件** → `git submodule add ...`
2. **自制插件** → 放到 `oh-my-zsh-custom/`，直接 `git add`
3. 修改 `.zshrc` → `git add .zshrc`
4. `git commit && git push`

恢复时只需要：

```bash
git clone ...
git submodule update --init --recursive
```

---

要不要我帮你把这些操作写进你仓库的 **README.md → FAQ 区**，比如「如何新增插件 / 如何删除插件」？这样以后就不会忘了流程。



