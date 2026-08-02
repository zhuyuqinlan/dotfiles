# =========================
# Zsh 基础配置
# =========================

# 自动补全
autoload -Uz compinit
compinit


# =========================
# 历史记录
# =========================

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt SHARE_HISTORY        # 多终端共享历史
setopt HIST_IGNORE_DUPS     # 忽略重复命令
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt APPEND_HISTORY


# =========================
# 补全体验优化
# =========================

# 大小写不敏感
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# 菜单选择
zstyle ':completion:*' menu select


# =========================
# 插件
# =========================

# 自动建议
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# 语法高亮（必须最后加载）
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# =========================
# Starship
# =========================

# eval "$(starship init zsh)"


# =========================
# fzf
# =========================

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# =========================
# Alias
# =========================

# ls增强
alias ls='eza --icons'
alias ll='eza -lah --icons'
alias la='eza -a --icons'

# cat增强
# alias cat='bat'

# 常用
alias cls='clear'
alias c='clear'

alias ..='cd ..'
alias ...='cd ../..'

# 查看端口
alias ports='ss -tulanp'


# =========================
# Git
# =========================

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'


# =========================
# Docker
# =========================

alias d='docker'
alias dc='docker compose'

alias dps='docker ps --format "table {{.ID}}	{{.Names}}	{{.Ports}}	{{.Status}}"' # 更友好的 Docker 容器列表
alias dis='docker images' # 显示 Docker 镜像
alias ta='tmux attach -t'
alias tw='tmux split-window'
alias twh='tmux split-window -h'
alias f='fastfetch'
alias ya='yazi'


# =========================
# Arch Linux
# =========================

# 更新系统（官方仓库 + AUR）
update() {
    paru -Syu
}

# 清理系统（孤儿包 + paru缓存）
cleanup() {
    echo "== 清理孤儿包 =="

    local orphans
    orphans=$(pacman -Qtdq)

    if [[ -n "$orphans" ]]; then
        sudo pacman -Rns --noconfirm $orphans
    else
        echo "没有孤儿包"
    fi

    echo "== 清理 pacman 缓存 =="
    sudo paccache -r

    echo "== 清理 paru AUR 缓存 =="
    paru -Sc --noconfirm

    echo "== 清理完成 =="
}


# =========================
# Node
# =========================

# alias ni='npm install'
# alias nr='npm run'
# alias nrd='npm run dev'
# alias nrb='npm run build'


# =========================
# PATH
# =========================

export PATH="$HOME/.local/bin:$PATH"


# =========================
# 终端体验
# =========================

# 自动进入目录
# setopt AUTO_CD

# 命令拼错自动修正
# setopt CORRECT

# fnm
eval "$(fnm env --use-on-cd --shell zsh)"

# 外观
PROMPT='%n@%m:%~$ '

# =========================
# 环境变量
# =========================
