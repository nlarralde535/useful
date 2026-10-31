 # # # # # # #
# new_worktree <new-branch> <base-branch>
#   Create a git worktree for a new branch based on an existing branch, under
#   /usr/local/worktrees/<repo-name>/, where <repo-name> comes from the
#   origin remote URL (e.g. cpanel-plugins, cpanel-meridian). Run from inside
#   the git repo or one of its worktrees.
#   Example: new_worktree DUCKS-1235 DUCKS-1234
# # # # # # #
export WORKTREE_BASE="/usr/local/worktrees/"
alias worktreepath_base="echo $WORKTREE_BASE"
alias gwl="echo -e  '\n========\nBRANCHES:' ; git branch ; echo -e '\n==================\nWORKTREE_DIRECTORY:\n$WORKTREE_BASE' ; echo -e '\n=========\nWORKTREES:' ; git worktree list"
alias gwa="git worktree add"
alias gwr="git worktree remove"
new_worktree() {
    local worktrees_base="/usr/local/worktrees"

    if [[ $# -ne 2 ]]; then
        echo "Error: expected exactly 2 arguments, got $#." >&2
        echo "Usage: new_worktree <new-branch> <base-branch>" >&2
        echo "  Example: new_worktree DUCKS-1235 DUCKS-1234" >&2
        return 1
    fi

    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "Error: not inside a git repository." >&2
        return 1
    fi

    # Name the worktree directory after the repo, taken from the origin remote
    # rather than the checkout directory: cpanel-plugins is checked out at
    # /usr/local/cpanel/plugins, whose basename is just "plugins".
    local origin_url
    if ! origin_url="$(git remote get-url origin 2>/dev/null)"; then
        echo "Error: no 'origin' remote; cannot determine the repo name." >&2
        return 1
    fi
    local repo_name
    repo_name="$(basename "${origin_url}" .git)"

    local new_branch="$1"
    local base_branch="$2"
    local worktree_root="${worktrees_base}/${repo_name}"
    local worktree_path="${worktree_root}/${base_branch}_${new_branch}"
    local disable_stop_hook_touch_file="${worktree_path}/.claude/stop-hooks.disabled"

    if ! git rev-parse --verify --quiet "refs/heads/${base_branch}" >/dev/null; then
        echo "Error: base branch '${base_branch}' does not exist." >&2
        return 1
    fi

    if git rev-parse --verify --quiet "refs/heads/${new_branch}" >/dev/null; then
        echo "Error: branch '${new_branch}' already exists." >&2
        return 1
    fi

    if [[ -e "${worktree_path}" ]]; then
        echo "Error: target path '${worktree_path}' already exists." >&2
        return 1
    fi

    mkdir -p "${worktree_root}"

    echo "Creating worktree:"
    echo "  new branch : ${new_branch}"
    echo "  base branch: ${base_branch}"
    echo "  location   : ${worktree_path}"

    git worktree add -b "${new_branch}" "${worktree_path}" "${base_branch}" || return 1
    echo "Done. cd ${worktree_path}"
}

# # # # # #
# PS1
# # # # # #
git_branches() {
    #git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    CENTRAL_NOTES_REPO_BRANCH=$(git -C /home/nic/Brain/Obsidian/Central-Notes-Repo branch 2> /dev/null | awk '$1 == "*" {printf "%s", $2}')
    USEFUL_REPO_BRANCH=$(git -C /home/nic/repos/useful branch 2> /dev/null | awk '$1 == "*" {printf "%s", $2}')
    SDE_AGENTIC_WORKFLOW_REPO_BRANCH=$(git -C /home/nic/repos/sde-agentic-workflow branch 2> /dev/null | awk '$1 == "*" {printf "%s", $2}')

    if [[ "$PWD" =~ ^/home/nic/Brain/Obsidian/Central-Notes-Repo(/|$) ]]
    then
        printf " ->[Central Notes Repo: %s]<-" "$CENTRAL_NOTES_REPO_BRANCH"
    elif [[ "$PWD" =~ ^/home/nic/repos/useful(/|$) ]]
    then
        printf " ->[Useful Repo: %s]<-" "$USEFUL_REPO_BRANCH"
    elif [[ "$PWD" =~ ^/home/nic/repos/sde-agentic-workflow(/|$) ]]
    then
        printf " ->[SDE Agentic Workflow Repo: %s]<-" "$SDE_AGENTIC_WORKFLOW_REPO_BRANCH"
    else
        printf " [no git repo here]"
    fi
}

# Article on changing PS1 Color
# https://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

export PS1="\n🔥🔥 ${GREEN}\_O_/ \_O_/${RESET} c8: CloudLinus 9  🔥🔥 ${GREEN}PWD:${RESET} \$PWD \n🔥🔥 ${GREEN}BRANCHES:${RESET}\$(git_branches)  ${GREEN}###===-->${RESET}\n"
