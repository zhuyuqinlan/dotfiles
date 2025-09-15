#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -l'
PS1='[\u@\h \W]\$ '

# NVM 配置
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/share/nvm/nvm.sh" ] && \. "/usr/share/nvm/nvm.sh"        # 加载 nvm
[ -s "/usr/share/nvm/bash_completion" ] && \. "/usr/share/nvm/bash_completion"  # bash 补全


alias dps='docker ps --format "table {{.ID}}	{{.Names}}	{{.Ports}}	{{.Status}}"' # 更友好的 Docker 容器列表
alias dis='docker images' # 显示 Docker 镜像
alias ta='tmux attach -t'
alias tw='tmux split-window'
alias twh='tmux split-window -h'
alias f='fastfetch'
alias ya='yazi'
