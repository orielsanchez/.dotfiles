# General Settings
export EDITOR=vim
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# Enable starship prompt
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
    starship preset gruvbox-rainbow -o ~/.config/starship.toml
fi

# Set PATH for macOS (Homebrew)
if [[ "$(uname)" == "Darwin" ]]; then
    export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
fi

# Linux Specific configuration
if [[ "$(uname)" == "Linux" ]]; then
    if [[ -f /etc/arch-release ]]; then
        alias update="sudo pacman -Syu"
    else
        alias update = "sudo apt update && sudo apt upgrade"
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


# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

autoload -U compinit && compinit
autoload -U promptinit && promptinit

fastfetch
source /usr/share/nvm/init-nvm.sh
=======

[ -f "/Users/oriel/.ghcup/env" ] && . "/Users/oriel/.ghcup/env" # ghcup-envexport PATH="/opt/homebrew/opt/curl/bin:$PATH"
