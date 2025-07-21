#!/usr/bin/env bash

#Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Command line programs
brew install tmux # Terminal session manager
brew install fzf # Search
brew install ripgrep 
brew install git
brew install gh # Github
brew install lazygit # Git UI
brew install neovim # Code editor
brew install ollama # Local AI models
brew install superfile # File manager

#SDKs & Runtimes
brew install node
brew install go
brew install rustup
brew install cocoapods # Required by Flutter iOS
brew install --cask corretto # OpenJDK
brew install --cask android-studio # Android SDK
brew install --cask flutter

curl -LsSf https://astral.sh/uv/install.sh | sh # Posting : Http client in the terminal

# Programs

brew install --cask zen-browser # Browser
brew install --cask ghostty # Terminal
brew install --cask raycast # Commands
brew install --cask figma

# Fonts
brew install --cask font-jetbrains-mono-nerd-font

# Required by Flutter
sudo softwareupdate --install-rosetta --agree-to-license

# Git configuration
git config --global pull.rebase false
git config --global user.email "alois.deniel@gmail.com"
git config --global user.name "Aloïs DENIEL"

# Remove outdated versions from the cellar.
brew cleanup
