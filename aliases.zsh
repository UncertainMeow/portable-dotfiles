#!/usr/bin/env zsh
# =============================================================================
# POKEBALL ALIASES - Your muscle memory, everywhere
# =============================================================================

# === Safety First ===
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# === The Essentials (why you're here) ===
alias ls='ls --color=auto 2>/dev/null || ls -G'
alias ll='ls -lAh'
alias la='ls -A'
alias l='ls -CF'
alias lh='ls -lh'

# === Directory Navigation ===
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# === Git (the shortcuts you actually use) ===
alias g='git'
alias gs='git status'
alias gst='git status'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'
alias glog='git log --oneline --graph --decorate'
alias gloga='git log --oneline --graph --decorate --all'
alias gst='git stash'
alias gstp='git stash pop'

# === System Info ===
alias df='df -h'
alias du='du -h'
alias duh='du -h --max-depth=1 | sort -h'
alias free='free -h 2>/dev/null || vm_stat'
alias ports='netstat -tulanp 2>/dev/null || lsof -i -P -n'

# === Quick Edits ===
alias v='${EDITOR:-vim}'
alias vi='${EDITOR:-vim}'
alias nano='${EDITOR:-vim}'  # Convert the heathens

# === Networking ===
alias myip='curl -s ifconfig.me'
alias localip='hostname -I 2>/dev/null | cut -d" " -f1 || ipconfig getifaddr en0 2>/dev/null'
alias ping='ping -c 5'
alias wget='wget -c'  # Resume by default

# === Quick Commands ===
alias h='history'
alias j='jobs -l'
alias c='clear'
alias cls='clear'
alias reload='exec ${SHELL} -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%Y-%m-%d %H:%M:%S"'

# === Grep with color ===
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# === File operations ===
alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'

# === Tail/Head shortcuts ===
alias tf='tail -f'
alias t100='tail -100'
alias h100='head -100'

# === Process management ===
alias psa='ps aux'
alias psg='ps aux | grep -v grep | grep'

# === Dotfiles Management ===
alias pokepull='cd ~/.portable-dotfiles && git pull && source ~/.zshrc && cd - >/dev/null'
alias pokestatus='cd ~/.portable-dotfiles && git status && cd - >/dev/null'

# === Useful one-liners ===
alias weather='curl -s wttr.in'
alias moon='curl -s wttr.in/Moon'
