#!/bin/bash

# install_asdf.sh
# Automated installer for asdf version manager on Ubuntu
# Supports Bash and Zsh

set -e # Exit immediately if a command exits with a non-zero status

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting asdf installation...${NC}"

# 1. Install Dependencies
echo -e "${BLUE}[1/4] Installing dependencies (git, curl)...${NC}"
if command -v apt-get &> /dev/null; then
    sudo apt-get update -qq
    sudo apt-get install -y -qq git curl
else
    echo -e "${RED}Error: 'apt-get' not found. This script is designed for Debian/Ubuntu systems.${NC}"
    exit 1
fi

# 2. Clone asdf Repository
ASDF_DIR="$HOME/.asdf"

echo -e "${BLUE}[2/4] Detecting latest asdf version...${NC}"
# Fetch latest tag from GitHub using git ls-remote to avoid API rate limits
ASDF_VERSION=$(git ls-remote --tags --refs --sort="v:refname" https://github.com/asdf-vm/asdf.git | tail -n1 | sed 's/.*\///')

if [ -z "$ASDF_VERSION" ]; then
    echo -e "${RED}Failed to fetch latest version. Fallback to v0.18.0${NC}"
    ASDF_VERSION="v0.18.0"
fi

echo -e "Latest version detected: ${GREEN}$ASDF_VERSION${NC}"

if [ -d "$ASDF_DIR" ]; then
    echo -e "${GREEN}asdf is already downloaded in $ASDF_DIR. Skipping clone.${NC}"
else
    git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" --branch "$ASDF_VERSION"
fi

# 3. Configure Shell
echo -e "${BLUE}[3/4] Configuring shell...${NC}"

# Detect shell based on current usage or default
CURRENT_SHELL=$(basename "$SHELL")
CONFIG_FILE=""

if [ "$CURRENT_SHELL" = "zsh" ]; then
    CONFIG_FILE="$ZDOTDIR/.zshrc"
elif [ "$CURRENT_SHELL" = "bash" ]; then
    CONFIG_FILE="$HOME/.bashrc"
else
    # Fallback: check which file exists
    if [ -f "$HOME/.zshrc" ]; then
        CONFIG_FILE="$HOME/.zshrc"
    elif [ -f "$HOME/.bashrc" ]; then
        CONFIG_FILE="$HOME/.bashrc"
    else
        echo -e "${RED}Could not detect .zshrc or .bashrc. Please add asdf to your path manually.${NC}"
        exit 1
    fi
fi

echo -e "Detected shell config: ${GREEN}$CONFIG_FILE${NC}"

# Check if already configured to avoid duplicates
if grep -q "asdf.sh" "$CONFIG_FILE"; then
    echo -e "${GREEN}asdf is already configured in $CONFIG_FILE.${NC}"
else
    echo -e "\n# asdf version manager configuration" >> "$CONFIG_FILE"
    echo ". \"$HOME/.asdf/asdf.sh\"" >> "$CONFIG_FILE"

    # Add completions specific to shell
    if [[ "$CONFIG_FILE" == *".zshrc"* ]]; then
        echo "fpath=(\${ASDF_DIR}/completions \$fpath)" >> "$CONFIG_FILE"
        echo "autoload -Uz compinit && compinit" >> "$CONFIG_FILE"
    else
        echo ". \"$HOME/.asdf/completions/asdf.bash\"" >> "$CONFIG_FILE"
    fi
    echo -e "${GREEN}Added configuration to $CONFIG_FILE${NC}"
fi

# 4. Final Instructions
echo -e "${BLUE}[4/4] Installation complete!${NC}"
echo -e "-----------------------------------------------------"
echo -e "To start using asdf, you must restart your terminal"
echo -e "or run the following command right now:"
echo -e ""
echo -e "${GREEN}source $CONFIG_FILE${NC}"
echo -e "-----------------------------------------------------"
