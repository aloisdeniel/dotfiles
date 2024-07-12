#!/usr/bin/env bash

#Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Command line
brew install neovim
brew install starship

#SDKs
brew install go
brew install --cask flutter

# Programs
brew install --cask iterm2
brew install --cask raycast
brew install --cask github
brew install --cask figma

# Fonts
brew install --cask font-caskaydia-cove-nerd-font

# Remove outdated versions from the cellar.
brew cleanup

# Go tools
go install github.com/a-h/templ/cmd/templ@latest
