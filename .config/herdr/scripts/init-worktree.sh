#!/usr/bin/env bash
#
# init-worktree.sh — initialize a new herdr worktree for a branch.
#
# Flow:
#   1. Prompt for a branch name with `gum` (https://github.com/charmbracelet/gum),
#      autocompleting from the branches that exist on `origin`. You may also type
#      a brand-new name that does not exist yet.
#   2. Create a herdr-managed git worktree (+ workspace) for that branch:
#        - new name           -> a fresh branch off origin's default branch.
#        - existing on origin  -> a local branch tracking origin/<branch>, pulled
#                                up to the latest remote commit.
#   3. Run init-dev.sh inside the new workspace to lay out the tabs.
#
# Run this from a pane that lives inside the herdr git work tree.

set -euo pipefail

HERDR="${HERDR_BIN_PATH:-herdr}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

die() { printf 'init-worktree: %s\n' "$1" >&2; exit 1; }

command -v "$HERDR" >/dev/null 2>&1 || die "herdr CLI not found (set HERDR_BIN_PATH)"
command -v git     >/dev/null 2>&1 || die "git is required but not installed"
command -v gum     >/dev/null 2>&1 || die "gum is required (https://github.com/charmbracelet/gum)"
command -v jq      >/dev/null 2>&1 || die "jq is required but not installed"

# Anchor every git/herdr action to the repo this pane sits in.
repo_root="$(git rev-parse --show-toplevel 2>/dev/null)" \
  || die "run this from inside the herdr git work tree"

# Refresh remote refs so both the autocomplete list and tracking are current.
printf 'init-worktree: fetching origin…\n' >&2
git -C "$repo_root" fetch --prune --quiet origin || die "git fetch origin failed"

# Branches that exist on origin, without the "origin/" prefix and minus HEAD.
origin_branches="$(git -C "$repo_root" for-each-ref --format='%(refname:short)' refs/remotes/origin \
  | sed 's#^origin/##' | grep -v '^HEAD$' || true)"

# Ask for the branch. Typing filters the origin branches; --no-strict makes gum
# return the typed text verbatim when it matches nothing, i.e. a brand-new branch.
branch="$(printf '%s\n' "$origin_branches" \
  | gum filter --no-strict --placeholder "Pick an origin branch or type a new one…" --prompt "branch › ")"
# gum may emit trailing whitespace/newlines; strip all whitespace (branch names have none).
branch="$(printf '%s' "${branch:-}" | tr -d '[:space:]')"
[ -n "$branch" ] || die "no branch selected"

# Pick the base ref: existing origin branch -> track and pull it; otherwise start
# a fresh branch from origin's default branch (falling back to current HEAD).
if git -C "$repo_root" show-ref --verify --quiet "refs/remotes/origin/$branch"; then
  exists_on_origin=1
  base="origin/$branch"
else
  exists_on_origin=0
  default_ref="$(git -C "$repo_root" symbolic-ref --quiet refs/remotes/origin/HEAD 2>/dev/null \
    | sed 's#^refs/remotes/##')"
  base="${default_ref:-HEAD}"
fi

# Create the herdr-managed worktree + workspace for the branch and focus it.
# Creating from a remote-tracking base sets up upstream tracking automatically.
printf 'init-worktree: creating worktree for "%s" (base %s)…\n' "$branch" "$base" >&2
create_json="$("$HERDR" worktree create \
  --cwd "$repo_root" \
  --branch "$branch" \
  --base "$base" \
  --label "$branch" \
  --focus \
  --json)" || die "herdr worktree create failed"

workspace_id="$(printf '%s' "$create_json" \
  | jq -r '.result.workspace.workspace_id // .result.workspace_id // .result.worktree.open_workspace_id // empty')"
[ -n "$workspace_id" ] || die "could not determine the new workspace id from: $create_json"

# Resolve the new checkout path so we can pull latest into it.
worktree_path="$(printf '%s' "$create_json" \
  | jq -r '.result.worktree.path // .result.workspace.worktree.path // empty')"
if [ -z "$worktree_path" ]; then
  worktree_path="$(git -C "$repo_root" worktree list --porcelain \
    | awk -v b="refs/heads/$branch" '
        /^worktree /{p=substr($0,10)}
        $0 == "branch " b {print p}')"
fi

# For an existing origin branch, ensure tracking and bring it up to date.
if [ "$exists_on_origin" -eq 1 ] && [ -n "$worktree_path" ]; then
  git -C "$worktree_path" branch --set-upstream-to "origin/$branch" "$branch" >/dev/null 2>&1 || true
  printf 'init-worktree: pulling latest origin/%s…\n' "$branch" >&2
  git -C "$worktree_path" pull --ff-only --quiet \
    || printf 'init-worktree: could not fast-forward origin/%s; resolve manually.\n' "$branch" >&2
fi

# Lay out the tabs in the freshly-created workspace.
HERDR_ACTIVE_WORKSPACE_ID="$workspace_id" "$SCRIPT_DIR/init-dev.sh"

printf 'init-worktree: ready — branch "%s" in workspace %s.\n' "$branch" "$workspace_id" >&2
