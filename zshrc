#!/usr/bin/env zsh
# =============================================================================
#  🔴 POKEBALL DOTFILES - Lightweight Shell for Adventures
# =============================================================================
# Zero dependencies. Works anywhere. Catches servers.

# Where we live
POKEBALL_DIR="${HOME}/.portable-dotfiles"

# XDG defaults (won't override if already set)
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# Essential environment
export EDITOR="${EDITOR:-vim}"
export VISUAL="$EDITOR"
export PAGER="less"

# History - actually useful settings
HISTFILE="${XDG_DATA_HOME}/zsh/history"
HISTSIZE=10000
SAVEHIST=$HISTSIZE
mkdir -p "$(dirname "$HISTFILE")" 2>/dev/null

# Shell options (the good ones)
setopt auto_cd              # Type directory name to cd
setopt extended_glob        # Better pattern matching
setopt no_beep              # Silence
setopt auto_pushd           # cd pushes to stack
setopt pushd_ignore_dups    # No dupe dirs in stack
setopt hist_ignore_space    # Space prefix = don't save
setopt hist_ignore_all_dups # No duplicate history
setopt share_history        # Share across sessions
setopt inc_append_history   # Write immediately

# PATH additions
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# =============================================================================
# KEYBINDINGS - Fixed so up arrow doesn't jump to beginning of line
# =============================================================================

# History search with cursor at END (not beginning!)
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey '^[[A' history-beginning-search-backward-end  # Up
bindkey '^[[B' history-beginning-search-forward-end   # Down

# Standard readline shortcuts
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^U' kill-whole-line
bindkey '^K' kill-line
bindkey '^W' backward-kill-word

# Word movement (works in most terminals)
bindkey '^[[1;3D' backward-word   # Alt+Left
bindkey '^[[1;3C' forward-word    # Alt+Right
bindkey '^[[1;5D' backward-word   # Ctrl+Left
bindkey '^[[1;5C' forward-word    # Ctrl+Right

# =============================================================================
# PROMPT - Simple, fast, shows what you need
# =============================================================================

autoload -U colors && colors

# Git branch in prompt (lightweight, no plugin needed)
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' %F{yellow}[%b]%f'
precmd() { vcs_info }
setopt prompt_subst

# user@host:~/path [branch]$
PROMPT='%F{cyan}%n@%m%f:%F{blue}%~%f${vcs_info_msg_0_}$ '

# =============================================================================
# COMPLETION - Basic but functional
# =============================================================================

autoload -Uz compinit
# Only regenerate completions once per day
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive

# =============================================================================
# LOAD ALIASES AND FUNCTIONS
# =============================================================================

[[ -f "$POKEBALL_DIR/aliases.zsh" ]] && source "$POKEBALL_DIR/aliases.zsh"
[[ -f "$POKEBALL_DIR/functions.zsh" ]] && source "$POKEBALL_DIR/functions.zsh"

# Local overrides (not tracked)
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# Caught!
echo "🔴 Pokeball loaded - 'pokepull' to update"
