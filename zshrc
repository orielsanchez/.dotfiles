# General Settings
export EDITOR=vim

# Set PATH for Cargo (this is used on both macOS and Linux)
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# Enable starship prompt if available
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
    starship preset nerd-font-symbols -o ~/.config/starship.toml
fi

# macOS-specific Homebrew and curl path
if [[ "$(uname)" == "Darwin" ]]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/opt/curl/bin:$PATH"
fi

# Linux-specific configuration (e.g., update aliases for Linux distributions)
if [[ "$(uname)" == "Linux" ]]; then
    if [[ -f /etc/arch-release ]]; then
        alias update="sudo pacman -Syu"
    else
        alias update="sudo apt update && sudo apt upgrade"
    fi
fi

# Common Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l="ls -CF"
alias so="source ~/.zshrc"
alias zshrc="nvim ~/.zshrc"
alias onedrivesync-down="rclone sync onedrive:library ~/onedrive-library"
alias onedrivesync-up="rclone sync ~/onedrive-library onedrive:library"
alias hx="helix"

# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Zsh autoload functions
autoload -U compinit && compinit
autoload -U promptinit && promptinit

# Optional: Fastfetch
fastfetch

# Initialize GHCup (Haskell toolchain) environment if present
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
