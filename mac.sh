#!/bin/bash
# Rising Tides Skills Pack — Mac Bootstrap
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
echo -e "${BLUE}   Rising Tides — Mac Bootstrap             ${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# --- Do NOT run as root ---
if [ "$(id -u)" -eq 0 ]; then
    echo -e "${RED}ERROR: Do not run this script with sudo.${NC}"
    echo "Run as your normal user. The script will prompt for your password when needed."
    exit 1
fi

# --- Step 1: Install Homebrew if missing ---
if ! command -v brew &>/dev/null; then
    echo -e "${YELLOW}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew to PATH for this session
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    echo -e "${GREEN}✓ Homebrew installed${NC}"
else
    echo -e "${GREEN}✓ Homebrew already installed${NC}"
fi

# --- Step 2: Install GitHub CLI if missing ---
if ! command -v gh &>/dev/null; then
    echo -e "${YELLOW}Installing GitHub CLI...${NC}"
    brew install gh
    echo -e "${GREEN}✓ GitHub CLI installed${NC}"
else
    echo -e "${GREEN}✓ GitHub CLI already installed${NC}"
fi

# --- Step 3: Authenticate if needed ---
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

# --- Step 4: Clone the private repo ---
echo ""
echo -e "${YELLOW}Cloning Rising Tides repo...${NC}"
rm -rf "$CLONE_DIR"
gh repo clone "$REPO" "$CLONE_DIR"
echo -e "${GREEN}✓ Repo cloned to $CLONE_DIR${NC}"

# --- Step 5: Run the real setup script ---
echo ""
echo -e "${BLUE}Launching setup...${NC}"
echo ""
bash "$CLONE_DIR/New user starter pack/scripts/setup-mac.sh"

# --- Step 6: Clean up ---
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
