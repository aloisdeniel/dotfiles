#!/usr/bin/env bash

# Install mise
/bin/bash -c "$(curl curl https://mise.run | sh)"

mise install

#Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

#Tools, SDKs & Runtimes
brew install git
brew install --cask android-studio # Android SDK

# Programs
brew install --cask zen-browser # Browser
brew install --cask ghostty # Terminal
brew install --cask figma

# Fonts
brew install --cask font-jetbrains-mono-nerd-font

# Required by Flutter
sdkmanager "platforms;android-36"
sdkmanager "build-tools;36.1.0"
sdkmanager "platform-tools"

# Git configuration
git config --global pull.rebase false
git config --global user.email "alois.deniel@gmail.com"
git config --global user.name "Aloïs DENIEL"

# Remove outdated versions from the cellar.
brew cleanup
