#!/usr/bin/env bash
# This script adds shortcuts to switch between desktops using CTRL+SHIFT+J/K/L on macOS.
set -euo pipefail

# Control (262144) + Shift (131072)
MODS=393216

set_space_shortcut() {
  local id="$1" ascii="$2" keycode="$3"
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$id" "
    <dict>
      <key>enabled</key><true/>
      <key>value</key>
      <dict>
        <key>type</key><string>standard</string>
        <key>parameters</key>
        <array>
          <integer>$ascii</integer>
          <integer>$keycode</integer>
          <integer>$MODS</integer>
        </array>
      </dict>
    </dict>
  "
}

set_space_shortcut 118 106 38 # Desktop 1 -> CTRL+SHIFT+J
set_space_shortcut 119 107 40 # Desktop 2 -> CTRL+SHIFT+K
set_space_shortcut 120 108 37 # Desktop 3 -> CTRL+SHIFT+L

# Apply without logging out
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

echo "Done. If the shortcuts don't take effect, log out and back in."
