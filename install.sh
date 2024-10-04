#!/usr/bin/env bash

#Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Command line programs
brew install fzf
brew install ripgrep
brew install lazygit
brew install neovim
brew install ollama

#SDKs & Runtimes
brew install node
brew install go
brew install rustup
brew install --cask flutter

# Programs
brew install --cask wezterm
brew install --cask raycast
brew install --cask github
brew install --cask figma

# Fonts
brew install --cask font-jetbrains-mono-nerd-font

# Remove outdated versions from the cellar.
brew cleanup

# Go tools
go install github.com/a-h/templ/cmd/templ@latest

# LLM models
ollama pull codestral
ollama pull gemma2:27b
