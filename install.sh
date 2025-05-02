#!/bin/bash

set -e

# === CONFIG ===
GIT_USERNAME="melhalees"
GIT_REPO_NAME="spring-init"
GIT_BRANCH_NAME="master"
SCRIPT_NAME="spring-init.sh"
GITHUB_URL="https://raw.githubusercontent.com/$GIT_USERNAME/$GIT_REPO_NAME/$GIT_BRANCH_NAME/$SCRIPT_NAME"
INSTALL_DIR="$HOME/.local/bin"

# === Detect OS ===
echo "🖥️ Detecting OS..."
OS=$(uname -s | tr '[:upper:]' '[:lower:]')

# Check if the OS is Windows (via WSL)
if [[ "$OS" == "mingw"* || "$OS" == "msys"* ]]; then
  OS="windows"
fi

# === Check if fzf is installed ===
if ! command -v fzf &> /dev/null; then
  echo "🔍 fzf not found, installing..."

  if [[ "$OS" == "linux" || "$OS" == "darwin" ]]; then
    if command -v apt &> /dev/null; then
      sudo apt update
      sudo apt install -y fzf
    elif command -v brew &> /dev/null; then
      brew install fzf
    else
      echo "❌ No known package manager found (apt/brew). Install fzf manually."
      exit 1
    fi
  elif [[ "$OS" == "windows" ]]; then
    echo "⚠️ fzf installation is not automated for Windows. Please install fzf manually via WSL or Git Bash."
    exit 1
  else
    echo "⚠️ Unsupported OS for automatic fzf install. Please install manually."
    exit 1
  fi
else
  echo "✅ fzf already installed"
fi

# === Check if jq is installed ===
if ! command -v jq &> /dev/null; then
  echo "🔍 jq not found, installing..."

  if [[ "$OS" == "linux" || "$OS" == "darwin" ]]; then
    if command -v apt &> /dev/null; then
      sudo apt update
      sudo apt install -y jq
    elif command -v brew &> /dev/null; then
      brew install jq
    else
      echo "❌ No known package manager found (apt/brew). Install jq manually."
      exit 1
    fi
  elif [[ "$OS" == "windows" ]]; then
    echo "⚠️ jq installation is not automated for Windows. Please install jq manually via WSL or Git Bash."
    exit 1
  else
    echo "⚠️ Unsupported OS for automatic jq install. Please install manually."
    exit 1
  fi
else
  echo "✅ jq already installed"
fi

# === Create install dir if needed ===
mkdir -p "$INSTALL_DIR"

# === Download the script ===
echo "⬇️ Downloading script from GitHub..."
curl -fsSL "$GITHUB_URL" -o "$INSTALL_DIR/spring-init"

# === Make it executable ===
chmod +x "$INSTALL_DIR/spring-init"

# === Add to PATH if not already ===
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
  echo "➕ Adding $INSTALL_DIR to PATH..."
  
  # For Linux/macOS
  if [[ "$OS" == "linux" || "$OS" == "darwin" ]]; then
    SHELL_RC="$HOME/.bashrc"
    [[ "$SHELL" == */zsh ]] && SHELL_RC="$HOME/.zshrc"
    echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$SHELL_RC"
    echo "🔁 Please restart your terminal or run: source $SHELL_RC"
  
  # For Windows (WSL or Git Bash)
  elif [[ "$OS" == "windows" ]]; then
    # Windows users should update the PATH in their profile or through system settings
    echo "🔁 Please manually add $INSTALL_DIR to your PATH in WSL or Git Bash profile."
  fi
fi

echo "🎉 Done! Run your CLI tool with: spring-init"
