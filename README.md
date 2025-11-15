# Portable Dotfiles

Lightweight, zero-dependency shell configuration for remote servers and minimal environments.

## Quick Install

One-liner install via curl:

```bash
curl -fsSL https://raw.githubusercontent.com/UncertainMeow/portable-dotfiles/main/bootstrap-portable.sh | bash
```

## What This Is

When you SSH into a remote server and type `ll` only to get "command not found" - that's what this solves.

This is a minimal, fast subset of dotfiles designed for:
- Remote servers accessed via SSH
- Containers and VMs
- Fresh Linux installs
- Any environment where you want your essential aliases and functions without the overhead

## Features

**All your muscle memory preserved:**
- Essential aliases (ll, la, gs, gst, gd, etc.)
- Core functions (mkcd, extract, ports, weather, etc.)
- Git-aware prompt with current directory
- Smart history configuration
- Fast and minimal - no plugins, themes, or slow startup

**Zero dependencies:**
- No oh-my-zsh required
- No plugin managers
- No external tools needed
- Works on any Linux distribution

**Self-updating:**
- `dotpull` alias to update from repository
- Auto-detects OS and adapts configuration

## What's Included

### Files
- `aliases.zsh` - Essential command aliases
- `functions.zsh` - Core utility functions
- `zshrc` - Minimal zsh configuration
- `bootstrap-portable.sh` - Automated installer

### Key Aliases
```bash
ll          # ls -lah
gs          # git status
gst         # git status
gd          # git diff
gco         # git checkout
gp          # git push
gl          # git pull
```

### Key Functions
```bash
mkcd        # Make directory and cd into it
extract     # Extract any archive format
ports       # Show listening ports
weather     # Get weather for a location
serve       # Start HTTP server in current directory
```

## Installation

### One-liner (recommended)
```bash
curl -fsSL https://raw.githubusercontent.com/UncertainMeow/portable-dotfiles/main/bootstrap-portable.sh | bash
```

### Manual Installation
```bash
# Clone the repository
git clone https://github.com/UncertainMeow/portable-dotfiles.git ~/.portable-dotfiles

# Source in your .zshrc
echo 'source ~/.portable-dotfiles/zshrc' >> ~/.zshrc

# Reload shell
exec zsh
```

## Updating

Built-in update command:
```bash
dotpull
```

Or manually:
```bash
cd ~/.portable-dotfiles && git pull
```

## Relationship to Main Dotfiles

This is the lightweight sibling of [UncertainMeow/dotfiles](https://github.com/UncertainMeow/dotfiles).

**Main dotfiles**: Full-featured development environment for your primary workstation
**Portable dotfiles**: Minimal essentials for remote servers and quick setups

Use main dotfiles on your development machine. Use portable dotfiles everywhere else.

## Philosophy

Fast, minimal, and dependency-free. If you need more features, use the main dotfiles. This is intentionally kept simple and focused.

## Requirements

- zsh (installed but doesn't need to be your default shell)
- git (for installation and updates)
- curl or wget (for one-liner install)

## Compatibility

Tested on:
- Ubuntu 20.04+
- Debian 11+
- CentOS 7+
- Fedora 35+
- Arch Linux
- macOS 11+

Works on any POSIX-compliant system with zsh available.

## License

MIT License - use freely, modify as needed
