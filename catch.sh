#!/usr/bin/env bash
# =============================================================================
#  🔴 POKEBALL - Catch this server!
# =============================================================================
# One-liner: curl -fsSL https://raw.githubusercontent.com/UncertainMeow/portable-dotfiles/main/catch.sh | bash

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m'

echo ""
echo -e "${RED}         ◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓${NC}"
echo -e "${RED}       ◓${NC}                           ${RED}◓${NC}"
echo -e "${RED}      ◓${NC}   ${WHITE}POKEBALL DOTFILES${NC}         ${RED}◓${NC}"
echo -e "${RED}      ◓${NC}                             ${RED}◓${NC}"
echo -e "${RED}      ◓${NC}   ${BLUE}Catching this server...${NC}    ${RED}◓${NC}"
echo -e "${RED}      ◓${NC}                             ${RED}◓${NC}"
echo -e "${RED}       ◓${NC}                           ${RED}◓${NC}"
echo -e "${WHITE}    ═══════════════════════════════════${NC}"
echo -e "${WHITE}       ◓${NC}                           ${WHITE}◓${NC}"
echo -e "${WHITE}      ◓${NC}                             ${WHITE}◓${NC}"
echo -e "${WHITE}      ◓${NC}      ${YELLOW}★${NC}  ${GREEN}★${NC}  ${BLUE}★${NC}              ${WHITE}◓${NC}"
echo -e "${WHITE}      ◓${NC}                             ${WHITE}◓${NC}"
echo -e "${WHITE}       ◓${NC}                           ${WHITE}◓${NC}"
echo -e "${WHITE}         ◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓◓${NC}"
echo ""

DOTFILES_DIR="$HOME/.portable-dotfiles"

# Detect OS
detect_os() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        OS=$ID
        OS_VERSION=${VERSION_ID:-"unknown"}
    elif command -v lsb_release >/dev/null 2>&1; then
        OS=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
        OS_VERSION=$(lsb_release -sr)
    else
        OS=$(uname -s | tr '[:upper:]' '[:lower:]')
        OS_VERSION="unknown"
    fi
    echo -e "${GREEN}✓${NC} Detected: $OS $OS_VERSION"
}

# Check for git
check_git() {
    if command -v git >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} Git available"
        return 0
    fi

    echo -e "${YELLOW}!${NC} Git not found - installing..."

    case "$OS" in
        ubuntu|debian|pop)
            sudo apt-get update -qq && sudo apt-get install -y -qq git
            ;;
        centos|rhel|rocky|alma)
            sudo yum install -y -q git || sudo dnf install -y -q git
            ;;
        fedora)
            sudo dnf install -y -q git
            ;;
        arch|manjaro)
            sudo pacman -Sy --noconfirm git
            ;;
        alpine)
            sudo apk add git
            ;;
        darwin)
            xcode-select --install 2>/dev/null || true
            ;;
        *)
            echo -e "${RED}✗${NC} Cannot install git on $OS - please install manually"
            exit 1
            ;;
    esac

    echo -e "${GREEN}✓${NC} Git installed"
}

# Check for zsh
check_zsh() {
    if command -v zsh >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} Zsh available"
        return 0
    fi

    echo -e "${YELLOW}!${NC} Zsh not found"
    echo ""
    echo "  Install zsh:"
    case "$OS" in
        ubuntu|debian|pop)  echo "    sudo apt install zsh" ;;
        centos|rhel|rocky)  echo "    sudo yum install zsh" ;;
        fedora)             echo "    sudo dnf install zsh" ;;
        arch|manjaro)       echo "    sudo pacman -S zsh" ;;
        alpine)             echo "    sudo apk add zsh" ;;
        darwin)             echo "    brew install zsh" ;;
    esac
    echo ""
    echo "  Then re-run this script."
    return 1
}

# Install dotfiles
install_dotfiles() {
    # Backup existing
    if [[ -f "$HOME/.zshrc" ]] && [[ ! -L "$HOME/.zshrc" ]]; then
        echo -e "${YELLOW}!${NC} Backing up existing .zshrc"
        mv "$HOME/.zshrc" "$HOME/.zshrc.pre-pokeball.$(date +%s)"
    fi

    # Clone or update
    if [[ -d "$DOTFILES_DIR" ]]; then
        echo -e "${BLUE}→${NC} Updating existing pokeball..."
        cd "$DOTFILES_DIR"
        git pull --quiet
    else
        echo -e "${BLUE}→${NC} Cloning pokeball dotfiles..."
        git clone --quiet https://github.com/UncertainMeow/portable-dotfiles.git "$DOTFILES_DIR"
    fi

    # Create necessary dirs
    mkdir -p "$HOME/.local/bin"
    mkdir -p "$HOME/.local/share/zsh"

    # Link zshrc
    ln -sf "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"

    echo -e "${GREEN}✓${NC} Dotfiles installed"
}

# Main
main() {
    detect_os
    check_git

    if ! check_zsh; then
        exit 1
    fi

    install_dotfiles

    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║         ${WHITE}Server caught!${GREEN}                   ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${BLUE}Next:${NC}"
    echo -e "    1. Start zsh:   ${WHITE}exec zsh${NC}"
    echo -e "    2. Test it:     ${WHITE}ll${NC}"
    echo -e "    3. Update:      ${WHITE}pokepull${NC}"
    echo -e "    4. Help:        ${WHITE}pokehelp${NC}"
    echo ""
    echo -e "  ${YELLOW}All your aliases work now!${NC}"
    echo ""
}

main
