#!/usr/bin/env bash
#
# init-dev.sh — initialize the tabs of the current herdr workspace for development.
#
# Only acts on a freshly-created (empty) workspace, i.e. one that still has a
# single tab. Sets up:
#   1. tab "editor" — two vertical panes (split left/right)
#   2. tab "lazygit"
#   3. tab "agent"
#
# Note: the herdr CLI/API cannot set split ratios (splits are always 50/50), so
# the requested "left pane 70%" is approximated and a notice is printed. Resize
# it manually with resize_mode (prefix+ctrl+r) if you need exactly 70%.

set -euo pipefail

HERDR="${HERDR_BIN_PATH:-herdr}"

die() { printf 'init-dev: %s\n' "$1" >&2; exit 1; }

command -v "$HERDR" >/dev/null 2>&1 || die "herdr CLI not found (set HERDR_BIN_PATH)"
command -v jq >/dev/null 2>&1 || die "jq is required but not installed"

# Resolve the target workspace: prefer the one herdr injected into our env (when
# run as a keybinding/command), otherwise fall back to the focused workspace.
workspace_id="${HERDR_ACTIVE_WORKSPACE_ID:-}"
if [ -z "$workspace_id" ]; then
  workspace_id="$("$HERDR" workspace list \
    | jq -r '.result.workspaces[] | select(.focused == true) | .workspace_id')"
fi
[ -n "$workspace_id" ] || die "could not determine the current workspace"

# Snapshot the workspace's tabs (ordered by number).
tabs_json="$("$HERDR" tab list --workspace "$workspace_id" \
  | jq -c '.result.tabs | sort_by(.number)')"

tab_count="$(printf '%s' "$tabs_json" | jq 'length')"
if [ "$tab_count" -ne 1 ]; then
  die "workspace $workspace_id has $tab_count tabs; expected 1 (empty). Aborting."
fi

# --- Tab 1: editor ---------------------------------------------------------
editor_tab_id="$(printf '%s' "$tabs_json" | jq -r '.[0].tab_id')"
[ -n "$editor_tab_id" ] && [ "$editor_tab_id" != "null" ] \
  || die "could not resolve the first tab id"

"$HERDR" tab rename "$editor_tab_id" "editor" >/dev/null

editor_pane_id="$("$HERDR" pane list --workspace "$workspace_id" \
  | jq -r --arg t "$editor_tab_id" \
      'first(.result.panes[] | select(.tab_id == $t) | .pane_id)')"
[ -n "$editor_pane_id" ] && [ "$editor_pane_id" != "null" ] \
  || die "could not resolve the editor tab's pane"

# Split into two vertical panes (left = original, right = new).
"$HERDR" pane split "$editor_pane_id" --direction right --no-focus >/dev/null
printf 'init-dev: editor split 50/50 (CLI cannot set the requested 70%% width — resize manually with resize_mode).\n' >&2

# --- Tab 2: lazygit --------------------------------------------------------
"$HERDR" tab create --workspace "$workspace_id" --label "lazygit" --no-focus >/dev/null

# --- Tab 3: agent ----------------------------------------------------------
"$HERDR" tab create --workspace "$workspace_id" --label "agent" --no-focus >/dev/null

# Leave the editor tab focused.
"$HERDR" tab focus "$editor_tab_id" >/dev/null

printf 'init-dev: workspace %s initialized (editor, lazygit, agent).\n' "$workspace_id"
