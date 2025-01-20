#!/usr/bin/env bash

#Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Command line programs
brew install tmux
brew install fzf
brew install ripgrep 
brew install lazygit # Git UI
brew install neovim # Code editor
brew install ollama # Local AI models
brew instal yazi # File manager

#SDKs & Runtimes
brew install node
brew install go
brew install rustup
brew install --cask corretto # OpenJDK
brew install --cask flutter

# Programs

brew install --cask ghostty # Terminal
brew install --cask raycast
brew install --cask github
brew install --cask figma

# Fonts
brew install --cask font-jetbrains-mono-nerd-font

# Remove outdated versions from the cellar.
brew cleanup
