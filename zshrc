alias so="source ~/.zshrc"
# General Settings
export EDITOR=vim

# Enable starship prompt
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
    starship preset gruvbox-rainbow -o ~/.config/starship.toml
fi

# Set PATH for macOS (Homebrew)
if [[ "$(uname)" == "Darwin"]]; then
    export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
fi

# Linux Specific configuration
if[[ "$(uname)" == "Linux"]]; then
    if [[ -f /etc/arch-release]]; then
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

# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

autoload -U compinit && compinit
autoload -U promptinit && promptinit

fastfetch
