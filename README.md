# Dotfiles Repository

This repository contains my personal configuration files (dotfiles) for various tools and applications such as Zsh, Neovim, Kitty terminal, Git, and more. It allows for easy setup and synchronization of my development environment across multiple machines.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Dependencies](#dependencies)
- [Usage](#usage)
  - [Adding New Dotfiles](#adding-new-dotfiles)
  - [Automated Weekly Commits](#automated-weekly-commits)
- [Directory Structure](#directory-structure)
- [Contributing](#contributing)
- [License](#license)

---

## Features

- **Unified Configuration**: Centralized management of configuration files.
- **Easy Setup**: Automated installation script for quick environment setup on new machines.
- **Version Control**: Track changes using Git, with automated weekly commits.
- **Symlink Management**: Use symbolic links to maintain consistency between the repository and the home directory.
- **Cross-Platform Support**: Works on Unix-like systems (macOS, Linux).

---

## Installation

### 1. Clone the Repository

```bash
git clone git@github.com:orielsanchez/.dotfiles.git ~/.dotfiles
```

### 2. Run the Install Script

```bash
cd ~/.dotfiles
./install.sh
```

This script will:

- Create symbolic links for all dotfiles in their appropriate locations.
- Install dependencies using Homebrew (if available).
- Backup existing configuration files by appending a `.bak` extension before overwriting.

---

## Dependencies

- **Git**: For cloning the repository and version control.
- **Zsh**: The Z shell, used as the default shell.
- **Homebrew** (optional): Used to install packages listed in the `Brewfile`.
  - Installation: [Homebrew Website](https://brew.sh/)

---

## Usage

### Adding New Dotfiles

1. **Move the Configuration File to the Repository**

   ```bash
   mv ~/.newconfig ~/.dotfiles/newconfig
   ```

2. **Create a Symlink**

   ```bash
   ln -s ~/.dotfiles/newconfig ~/.newconfig
   ```

3. **Commit and Push Changes**

   ```bash
   cd ~/.dotfiles
   git add newconfig
   git commit -m "Add newconfig"
   git push
   ```

### Automated Weekly Commits

An `autocommit.sh` script is included to automate weekly commits and pushes of any changes to the dotfiles.

#### Setting Up the Cron Job

1. **Make the Script Executable**

   ```bash
   chmod +x ~/.dotfiles/autocommit.sh
   ```

2. **Edit Crontab**

   ```bash
   crontab -e
   ```

3. **Add the Following Line**

   ```cron
   0 1 * * 0 ~/.dotfiles/autocommit.sh
   ```

   This schedules the script to run every Sunday at 1 AM.

---

## Directory Structure

```
~/.dotfiles/
├── install.sh          # Installation script
├── autocommit.sh       # Script for automated commits
├── Brewfile            # Homebrew dependencies
├── zshrc               # Zsh configuration
├── zprofile            # Zsh profile
├── gitconfig           # Git configuration
├── config/             # Application configurations
│   ├── nvim/           # Neovim configuration
│   ├── kitty/          # Kitty terminal configuration
│   └── ...             # Other configurations
└── .gitignore          # Git ignore file
```

---

## Contributing

While this repository is primarily for personal use, suggestions and improvements are welcome. Feel free to open an issue or submit a pull request.

---

## License

This project is open-source and available under the [MIT License](LICENSE).

---
