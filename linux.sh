#!/bin/bash
# Rising Tides Skills Pack — Linux/WSL2 Bootstrap
# This script installs gh CLI, authenticates, clones the private repo, and runs setup.
# Safe to run multiple times. Contains no product content — just bootstrap logic.

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

CLONE_DIR="/tmp/rising-tides"
REPO="SunsetSystemsAI/rising-tides-starter-pack"

echo ""
echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}   Rising Tides — Linux/WSL2 Bootstrap      ${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# --- Do NOT run as root ---
if [ "$(id -u)" -eq 0 ]; then
    echo -e "${RED}ERROR: Do not run this script with sudo.${NC}"
    echo "Run as your normal user. The script will use sudo only when needed."
    exit 1
fi

# --- Step 1: Install GitHub CLI if missing ---
if ! command -v gh &>/dev/null; then
    echo -e "${YELLOW}Installing GitHub CLI...${NC}"

    # Detect package manager
    if command -v apt-get &>/dev/null; then
        # Debian/Ubuntu
        (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y))
        sudo mkdir -p -m 755 /etc/apt/keyrings
        out=$(mktemp)
        wget -nv -O "$out" https://cli.github.com/packages/githubcli-archive-keyring.gpg
        cat "$out" | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
        sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt update
        sudo apt install gh -y
        rm -f "$out"
    elif command -v dnf &>/dev/null; then
        # Fedora/RHEL
        sudo dnf install -y 'dnf-command(config-manager)'
        sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
        sudo dnf install -y gh
    elif command -v yum &>/dev/null; then
        # Older RHEL/CentOS
        sudo yum-config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
        sudo yum install -y gh
    elif command -v pacman &>/dev/null; then
        # Arch
        sudo pacman -S --noconfirm github-cli
    else
        echo -e "${RED}Could not detect package manager. Install gh CLI manually:${NC}"
        echo "  https://cli.github.com"
        exit 1
    fi

    echo -e "${GREEN}✓ GitHub CLI installed${NC}"
else
    echo -e "${GREEN}✓ GitHub CLI already installed${NC}"
fi

# --- Step 2: Authenticate if needed ---
if ! gh auth status &>/dev/null 2>&1; then
    echo ""
    echo -e "${YELLOW}You need to authenticate with GitHub to access the private repo.${NC}"
    echo ""
    gh auth login
    echo ""
    echo -e "${GREEN}✓ GitHub authenticated${NC}"
else
    echo -e "${GREEN}✓ GitHub already authenticated${NC}"
fi

# --- Step 3: Clone the private repo ---
echo ""
echo -e "${YELLOW}Cloning Rising Tides repo...${NC}"
rm -rf "$CLONE_DIR"
gh repo clone "$REPO" "$CLONE_DIR"
echo -e "${GREEN}✓ Repo cloned to $CLONE_DIR${NC}"

# --- Step 4: Run the real setup script ---
echo ""
echo -e "${BLUE}Launching setup...${NC}"
echo ""
bash "$CLONE_DIR/New user starter pack/scripts/setup-linux.sh"

# --- Step 5: Clean up ---
echo ""
echo -e "${YELLOW}Cleaning up temporary files...${NC}"
rm -rf "$CLONE_DIR"
echo -e "${GREEN}✓ Cleanup complete${NC}"
echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}   All done! Start Claude Code and try:     ${NC}"
echo -e "${GREEN}   /recommend skills                        ${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
