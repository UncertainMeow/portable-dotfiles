# Pokeball Dotfiles

```
         ╭──────────────────────────────────────╮
         │     🔴 POKEBALL DOTFILES 🔴          │
         │                                      │
         │  ◓ Lightweight shell for adventures  │
         │  ◓ Catching servers since 2024       │
         │  ◓ Zero dependencies                 │
         │                                      │
         │     "Gotta admin 'em all!"           │
         ╰──────────────────────────────────────╯
```

Ultra-lightweight shell config for remote servers. When you SSH into a machine and `ll` doesn't work - throw a pokeball at it.

## Quick Catch

```bash
curl -fsSL https://raw.githubusercontent.com/UncertainMeow/portable-dotfiles/main/catch.sh | bash
```

That's it. Server caught.

## What This Is

Your creature comforts for when you're out adventuring:

- **`ll`** works everywhere
- **`gs`** / **`gst`** for git status
- **Up arrow** searches history properly (cursor stays at end)
- **Tab completion** just works
- **Fast** - no plugins, no themes, no waiting

This is intentionally minimal. Your homelab main machine has the full setup. This is what you throw at every server you touch so you're not fighting muscle memory.

## Features

**Muscle Memory Preserved**
```bash
ll              # ls -lAh (the one you actually use)
la              # ls -A
gs / gst        # git status
gd              # git diff
gco             # git checkout
..  ...  ....   # cd up directories
```

**Essential Functions**
```bash
mkcd foo        # mkdir + cd in one
up 3            # go up 3 directories
extract file.gz # handles any archive format
bak config.yml  # quick timestamped backup
listening       # show all listening ports
serve 8080      # instant HTTP server
```

**Fixed Keybindings**
- Up/Down arrows search history by prefix, cursor stays at END (not beginning)
- Standard readline shortcuts (Ctrl+A/E/U/K/W)

**Zero Dependencies**
- No oh-my-zsh
- No plugin managers
- No external tools
- Works on any Linux with zsh

## Install Methods

### One-liner (Recommended)
```bash
curl -fsSL https://raw.githubusercontent.com/UncertainMeow/portable-dotfiles/main/catch.sh | bash
```

### Manual
```bash
git clone https://github.com/UncertainMeow/portable-dotfiles.git ~/.portable-dotfiles
echo 'source ~/.portable-dotfiles/zshrc' >> ~/.zshrc
exec zsh
```

### From Another Machine
```bash
# SSH in and catch it remotely
ssh user@server 'curl -fsSL https://raw.githubusercontent.com/UncertainMeow/portable-dotfiles/main/catch.sh | bash'
```

## Updating

```bash
pokepull    # pull latest and reload
```

Or manually:
```bash
cd ~/.portable-dotfiles && git pull && source ~/.zshrc
```

## Quick Reference

| Alias | Does |
|-------|------|
| `ll` | `ls -lAh` |
| `la` | `ls -A` |
| `gs` | `git status` |
| `gst` | `git status` |
| `gd` | `git diff` |
| `gco` | `git checkout` |
| `gb` | `git branch` |
| `gp` | `git push` |
| `gl` | `git pull` |
| `glog` | pretty git log |
| `..` | `cd ..` |
| `...` | `cd ../..` |
| `myip` | show external IP |
| `c` | clear |
| `h` | history |
| `pokepull` | update dotfiles |

| Function | Does |
|----------|------|
| `mkcd dir` | mkdir + cd |
| `up N` | go up N directories |
| `extract file` | extract any archive |
| `bak file` | timestamped backup |
| `listening` | show listening ports |
| `psg name` | grep for process |
| `serve [port]` | HTTP server (default 8000) |

## Compatibility

Tested on:
- Ubuntu 20.04+
- Debian 11+
- CentOS 7+ / RHEL
- Fedora 35+
- Arch Linux
- Alpine Linux
- macOS 11+

If it has zsh, it works.

## Relationship to Main Dotfiles

This is the travel-size version of [UncertainMeow/dotfiles](https://github.com/UncertainMeow/dotfiles).

| Repo | Use Case |
|------|----------|
| **dotfiles** | Full setup for your main workstation |
| **portable-dotfiles** | Throw at every server you touch |

## Philosophy

When you SSH into a random server at 2am because something's on fire, you shouldn't have to remember that `ll` is actually `ls -la` here but `ls -lah` there and wait why doesn't it even exist...

Throw a pokeball at it. Now it works like home.

---

*"A wild server appeared!"*
