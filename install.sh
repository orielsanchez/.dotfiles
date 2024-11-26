#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
echo "Starting dotfiles installation..."

echo "Cloning dotfiles repository..."
if [ ! -d "$HOME/.dotfiles" ]; then
    git clone git@github.com:orielsanchez/.dotfiles.git ~/.dotfiles
else
    echo "Dotfiles repository already exists, skipping clone."
fi


# Paths
DOTFILES_DIR="$HOME/.dotfiles"
LOCAL_BIN="$HOME/.local/bin"
DOTFILES_BIN="$DOTFILES_DIR/bin"
CONFIG_DIR="$HOME/.config"
DOTFILES_CONFIG="$DOTFILES_DIR/config"

# Determine the OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="mac"
elif [[ -f "/etc/arch-release" ]]; then
    OS="arch"
else
    echo "Unsupported OS"
    exit 1
fi

# Install dependencies based on OS
echo "Installing dependencies for $OS..."
if [[ "$OS" == "mac" ]]; then
    # macOS-specific installation
    if command -v brew &> /dev/null; then
        echo "Homebrew found, installing packages from Brewfile..."
        brew bundle --file="$DOTFILES_DIR/Brewfile"
    else 
        echo "Homebrew not found, installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew bundle --file "$DOTFILES_DIR/Brewfile"
    fi
    # Setup Launchd task for auto-commit (macOS only)
    LAUNCHD_SRC="$DOTFILES_DIR/system/launchd/com.dotfiles.autocommit.plist"
    LAUNCHD_DEST="$HOME/Library/LaunchAgents/com.dotfiles.autocommit.plist"
    echo "Setting up Launchd task for auto-commit..."
    if [ -f "$LAUNCHD_SRC" ]; then
        # Ensure LaunchAgents directory exists
        mkdir -p "$HOME/Library/LaunchAgents"

        # Copy or symlink the plist file
        ln -sf "$LAUNCHD_SRC" "$LAUNCHD_DEST"
        # Load the Launchd task
        launchctl unload "$LAUNCHD_DEST" 2>/dev/null || true  # Unload if already loaded
        launchctl load "$LAUNCHD_DEST"                       # Load the plist file
        echo "Launchd task for auto-commit successfully set up."
    else
        echo "Error: Launchd plist file not found at $LAUNCHD_SRC"
    fi

elif [ "$OS" == "arch" ]; then
    # Arch Linux-specific installation
    echo "installing required packages using pacman..."
    sudo pacman -Syu --needed base-devel git neovim kitty ripgrep fd starship zsh rustup uv
fi

# Ensure required directories exist
echo "Ensuring necessary directories exist..."
mkdir -p "$LOCAL_BIN"
mkdir -p "$CONFIG_DIR"
mkdir -p "$HOME/projects"         # Projects directory
mkdir -p "$HOME/tmp"              # Temporary files director

# Symlink Config Files
echo "Symlinking configuration files..."
ln -sf "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/zprofile" "$HOME/.zprofile"

# Symlink Config Directories
echo "Symlinking configuration directories..."
for config in "$DOTFILES_CONFIG"/*; do
    config_name=$(basename "$config")
    ln -sf "$config" "$CONFIG_DIR/$config_name"
done

# Symlink Kitty and Neovim Configurations
echo "Symlinking kitty and nvim configurations..."
ln -sf "$DOTFILES_CONFIG/kitty" "$CONFIG_DIR/kitty"
ln -sf "$DOTFILES_CONFIG/nvim" "$CONFIG_DIR/nvim"

# Symlink Binaries from Dotfiles
echo "Symlinking binaries from dotfiles..."
for binary in "$DOTFILES_BIN"/*; do
    binary_name=$(basename "$binary")
    ln -sf "$binary" "$LOCAL_BIN/$binary_name"
done

# Add Local Binaries to PATH
if ! echo "$PATH" | grep -q "$LOCAL_BIN"; then
    echo "Adding $LOCAL_BIN to PATH in ~/.zshrc..."
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
fi

# Backup Existing Files (Optional)
echo "Backing up existing files..."
BACKUP_DIR="$DOTFILES_DIR/backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
for file in "$HOME/.zshrc" "$HOME/.zprofile" "$CONFIG_DIR/*"; do
    [ -e "$file" ] && mv "$file" "$BACKUP_DIR"
done
echo "Backup saved to $BACKUP_DIR."

echo "Dotfiles installation complete!"
