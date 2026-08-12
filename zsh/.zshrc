# =========================
# Zsh 基础配置
# =========================

autoload -Uz compinit
compinit


# =========================
# 历史记录
# =========================

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
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
# Fedora Zsh 插件
# =========================

# 自动建议
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# 语法高亮（必须最后加载）
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


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
alias lse='eza --icons'
alias lle='eza -lah --icons'
alias lae='eza -a --icons'

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

alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}\t{{.Status}}"'

alias dis='docker images'

alias ta='tmux attach -t'
alias tw='tmux split-window'
alias twh='tmux split-window -h'

alias f='fastfetch'


# =========================
# Fedora 系统更新
# =========================

update() {
    sudo dnf upgrade --refresh
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

# =========================
# 外观
# =========================

PROMPT='%n@%m:%~$ '

# fnm
FNM_PATH="/home/zhuyuqinlan/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi
eval "$(fnm env --use-on-cd --shell zsh)"


# =========================
# 环境变量
# =========================
export JAVA_HOME=$HOME/program/jdk/jdk17
export PATH=$JAVA_HOME/bin:$PATH


