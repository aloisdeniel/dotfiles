#!/usr/bin/env bash

#Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew upgrade

brew install git
brew install gh
brew install --cask android-studio # Android SDK
brew install --cask zen-browser    # Browser
brew install --cask ghostty        # Terminal
brew install --cask figma
brew install --cask font-jetbrains-mono-nerd-font

brew cleanup

# Mise
/bin/bash -c "$(curl curl https://mise.run | sh)"
gh auth login
export MISE_GITHUB_TOKEN=$(gh auth token)
mise install

# Required by Flutter
sdkmanager "platforms;android-36"
sdkmanager "build-tools;36.1.0"
sdkmanager "platform-tools"

# Git configuration
git config --global pull.rebase false
git config --global user.email "alois.deniel@gmail.com"
git config --global user.name "Aloïs DENIEL"
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global delta.dark true
git config --global merge.conflictStyle zdiff3

# Adds shortcuts to switch between desktops using CTRL+SHIFT+J/K/L
sh macos-desktop-shortcuts.sh
