#!/bin/sh
# opencode portable setup script
# Run this script to download opencode and configure your API key.

set -e

DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
BIN_DIR="$DIR/bin"
HOME_DIR="$DIR/home"
CONFIG_DIR="$HOME_DIR/.config/opencode"

echo "=== opencode Portable Setup ==="
echo ""

# Download opencode
echo "[1/3] Downloading opencode..."
mkdir -p "$BIN_DIR"

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$ARCH" in
    x86_64)  ARCH="amd64" ;;
    aarch64) ARCH="arm64" ;;
    arm64)   ARCH="arm64" ;;
esac

case "$OS" in
    linux)
        URL="https://github.com/anomalyco/opencode/releases/latest/download/opencode-linux-${ARCH}.tar.gz"
        ;;
    darwin)
        URL="https://github.com/anomalyco/opencode/releases/latest/download/opencode-darwin-${ARCH}.tar.gz"
        ;;
    *)
        echo "Unsupported OS: $OS"
        echo "Please manually download from https://github.com/anomalyco/opencode/releases"
        exit 1
        ;;
esac

curl -fsSL "$URL" -o /tmp/opencode.tar.gz
tar -xzf /tmp/opencode.tar.gz -C "$BIN_DIR"
chmod +x "$BIN_DIR/opencode"
rm /tmp/opencode.tar.gz

echo "Done: opencode installed to $BIN_DIR"

# Setup home directory
echo "[2/3] Setting up home directory..."
mkdir -p "$CONFIG_DIR"

# Config
if [ ! -f "$CONFIG_DIR/config.json" ]; then
    echo "Enter your API key (get one at https://console.anthropic.com or https://platform.deepseek.com):"
    read -r API_KEY
    printf '{\n    "model": "deepseek/deepseek-v4-pro",\n    "api_key": "%s"\n}\n' "$API_KEY" > "$CONFIG_DIR/config.json"
    echo "Config created."
else
    echo "Config already exists, skipping."
fi

# Permission config
cat > "$CONFIG_DIR/opencode.json" << 'EOF'
{
    "$schema": "https://opencode.ai/config.json",
    "permission": "allow"
}
EOF

# Create .cache, .local
mkdir -p "$HOME_DIR/.cache/opencode"
mkdir -p "$HOME_DIR/.local/share/opencode"

echo "[3/3] Setup complete!"
echo ""
echo "To start opencode portable:"
echo "  Linux/Mac: bash $DIR/opencode.sh"
echo "  Windows:   double-click $DIR/opencode.bat"
