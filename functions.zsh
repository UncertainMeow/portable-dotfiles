#!/usr/bin/env zsh
# =============================================================================
# POKEBALL FUNCTIONS - Lightweight utilities for adventures
# =============================================================================

# Make directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Go up N directories
up() {
    local levels=${1:-1}
    local path=""
    for ((i=0; i<levels; i++)); do
        path="../$path"
    done
    cd "$path" || return 1
}

# Extract any archive format
extract() {
    if [[ ! -f "$1" ]]; then
        echo "extract: '$1' is not a valid file"
        return 1
    fi

    case "$1" in
        *.tar.bz2)   tar xjf "$1"     ;;
        *.tar.gz)    tar xzf "$1"     ;;
        *.tar.xz)    tar xJf "$1"     ;;
        *.bz2)       bunzip2 "$1"     ;;
        *.rar)       unrar x "$1"     ;;
        *.gz)        gunzip "$1"      ;;
        *.tar)       tar xf "$1"      ;;
        *.tbz2)      tar xjf "$1"     ;;
        *.tgz)       tar xzf "$1"     ;;
        *.zip)       unzip "$1"       ;;
        *.Z)         uncompress "$1"  ;;
        *.7z)        7z x "$1"        ;;
        *.xz)        unxz "$1"        ;;
        *)           echo "extract: '$1' - unknown archive format" ;;
    esac
}

# Quick timestamped backup
bak() {
    if [[ -z "$1" ]]; then
        echo "Usage: bak <file>"
        return 1
    fi
    cp -a "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)"
}

# Find process by name
psg() {
    ps aux | grep -v grep | grep -i -e VSZ -e "$1"
}

# Show all listening ports
listening() {
    if command -v ss >/dev/null 2>&1; then
        ss -tlnp
    elif command -v lsof >/dev/null 2>&1; then
        lsof -i -P -n | grep LISTEN
    elif command -v netstat >/dev/null 2>&1; then
        netstat -tulanp 2>/dev/null | grep LISTEN
    else
        echo "No ss, lsof, or netstat available"
    fi
}

# Quick HTTP server
serve() {
    local port=${1:-8000}
    echo "Serving on http://localhost:$port (Ctrl+C to stop)"
    if command -v python3 >/dev/null 2>&1; then
        python3 -m http.server "$port"
    elif command -v python >/dev/null 2>&1; then
        python -m SimpleHTTPServer "$port"
    else
        echo "No python available"
        return 1
    fi
}

# Show largest files/dirs in current directory
biggest() {
    local count=${1:-10}
    du -ah . 2>/dev/null | sort -rh | head -n "$count"
}

# Find files by name (simple, no fzf required)
ff() {
    if [[ -z "$1" ]]; then
        echo "Usage: ff <pattern>"
        return 1
    fi
    find . -iname "*$1*" 2>/dev/null
}

# Find and cd to directory
fcd() {
    local dir
    if command -v fzf >/dev/null 2>&1; then
        dir=$(find . -type d 2>/dev/null | fzf +m) && cd "$dir"
    else
        echo "fcd requires fzf - try: ff <pattern> then cd"
    fi
}

# Quick system info
sysinfo() {
    echo "=== System ==="
    uname -a
    echo ""
    echo "=== Uptime ==="
    uptime
    echo ""
    echo "=== Memory ==="
    free -h 2>/dev/null || vm_stat 2>/dev/null | head -10
    echo ""
    echo "=== Disk ==="
    df -h / 2>/dev/null
    echo ""
    echo "=== Network ==="
    hostname -I 2>/dev/null || ipconfig getifaddr en0 2>/dev/null || echo "Check: ip addr"
}

# Colored man pages
man() {
    LESS_TERMCAP_mb=$'\e[1;32m' \
    LESS_TERMCAP_md=$'\e[1;32m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[1;4;31m' \
    command man "$@"
}

# Show what's taking up space
diskspace() {
    echo "=== Largest directories in / ==="
    sudo du -h --max-depth=1 / 2>/dev/null | sort -rh | head -15
}

# Quick note taking (appends to ~/notes.txt)
note() {
    if [[ -z "$1" ]]; then
        echo "Usage: note <text>"
        echo "Notes saved to: ~/notes.txt"
        return 1
    fi
    echo "[$(date '+%Y-%m-%d %H:%M')] $*" >> ~/notes.txt
    echo "Note saved."
}

# Show notes
notes() {
    if [[ -f ~/notes.txt ]]; then
        cat ~/notes.txt
    else
        echo "No notes yet. Use: note <text>"
    fi
}

# Colorful help
pokehelp() {
    echo ""
    echo "  🔴 POKEBALL DOTFILES - Quick Reference"
    echo "  ═══════════════════════════════════════"
    echo ""
    echo "  Navigation:"
    echo "    ll          List files (long format)"
    echo "    ..  ...     Go up directories"
    echo "    mkcd dir    Make and enter directory"
    echo "    up N        Go up N directories"
    echo ""
    echo "  Git:"
    echo "    gs / gst    Git status"
    echo "    ga / gaa    Git add / add all"
    echo "    gc / gcm    Git commit"
    echo "    gd / gds    Git diff / staged diff"
    echo "    gp / gl     Git push / pull"
    echo "    gco / gcb   Checkout / checkout -b"
    echo ""
    echo "  Utilities:"
    echo "    extract f   Extract any archive"
    echo "    bak file    Quick backup"
    echo "    serve 8000  HTTP server"
    echo "    listening   Show open ports"
    echo "    biggest     Largest files here"
    echo "    sysinfo     System overview"
    echo ""
    echo "  Updates:"
    echo "    pokepull    Update pokeball dotfiles"
    echo ""
}
