# useful

My personal collection of shell and editor config, plus Claude Code harness
tools (settings, a status line, an output style, rules, and skills).

## Layout

```
.
├── config/
│   ├── .bashrc
│   └── .vimrc
└── harness-tools/
    ├── settings.json
    ├── statusline-command.sh
    ├── output-styles/
    │   └── simple-english.md
    ├── rules/
    │   └── nics-rules/
    │       └── commit-messages.md
    └── skills/
        └── label-react-nouns/
            ├── SKILL.md
            └── references/
                └── nouns.md
```

## config/

Dotfiles for the shell and editor.

### `.bashrc`

- **Git worktree helpers**
  - `gwl` lists the local branches, the worktree base directory, and all
    worktrees.
  - `gwa` and `gwr` are short aliases for `git worktree add` and
    `git worktree remove`.
  - `new_worktree <new-branch> <base-branch>` creates a new branch from a base
    branch in its own worktree at
    `/usr/local/worktrees/<repo-name>/<base-branch>_<new-branch>`. The repo name
    comes from the `origin` remote URL, not the checkout directory. The function
    checks its arguments, the base branch, and the target path before it runs.
- **Prompt (`PS1`)** — a two-line colored prompt that shows the working
  directory and, through `git_branches`, the current branch of a few known
  repos (Central Notes Repo, this repo, and SDE Agentic Workflow) when you are
  inside one of them.

### `.vimrc`

- Highlights the cursor line in the active window only.
- Maps `Ctrl-h/j/k/l` to move between split windows.

## harness-tools/

Configuration and extensions for [Claude Code](https://claude.com/claude-code).
These files are meant to be copied (or symlinked) into `~/.claude/`.

### `settings.json`

Global Claude Code settings:

- Uses `statusline-command.sh` as the status line, refreshed every 10 seconds.
  The path in the file points to `/root/.claude/statusline-command.sh`. Change
  it to match where you install the script.
- Sets `EDITOR=vim`.
- Allows `git log` and `git grep` without a prompt.
- Denies `git push` and `git checkout`.
- Sets the default model to `opus`.

### `statusline-command.sh`

A status line script. It reads the session JSON that Claude Code sends on stdin
and prints one line:

```
<tokens used> / <context window size> | <cwd> | <git branch> | $<session cost>
```

It uses `jq` when available and falls back to `python3`. The home directory is
shown as `~`, and a detached HEAD shows the short commit hash.

### `output-styles/simple-english.md`

The `simple-english` output style. It tells Claude to write technical prose
(docs, READMEs, commit messages, explanations) in ASD-STE100 Simplified
Technical English: short sentences, a fixed set of verbs and modals, one word
per meaning, and no filler words. Code, identifiers, and commands are left as
they are.

### `rules/nics-rules/commit-messages.md`

A rule that defines my commit message format:

```
<type>(<ProjectID>): <short summary, max 72 chars>

<body wrapped at 80 chars that describes only this commit's changes>
```

`<type>` is one of `major`, `minor`, `patch`, or `fix`. If no project ID is
given, Claude must ask for one before it commits.

### `skills/label-react-nouns/`

A manual-only skill, invoked with `/label-react-nouns`. It rewrites an answer
(or answers a new question) and adds a short label after each code symbol that
says what kind of thing the symbol is, for example `useTimelineData` (custom
data hook). It is a learning aid.

- `SKILL.md` holds the procedure, the scope and placement rules, and a
  self-check.
- `references/nouns.md` holds the allowed labels (components, hooks, data and
  values, and more), with recognition rules and examples.

The vocabulary is specific to the timeline React app in Central-Notes-Repo.
Review and adapt it before you use it with another codebase.

## Install

Copy or symlink the files to the locations that each tool reads. For example:

```bash
ln -s "$PWD/config/.vimrc" ~/.vimrc
cat config/.bashrc >> ~/.bashrc   # or source it from your existing .bashrc

mkdir -p ~/.claude
ln -s "$PWD/harness-tools/settings.json"         ~/.claude/settings.json
ln -s "$PWD/harness-tools/statusline-command.sh" ~/.claude/statusline-command.sh
ln -s "$PWD/harness-tools/output-styles"         ~/.claude/output-styles
ln -s "$PWD/harness-tools/rules"                 ~/.claude/rules
ln -s "$PWD/harness-tools/skills"                ~/.claude/skills
```

Several paths are specific to my machines (`/usr/local/worktrees`, the repo
paths in `git_branches`, and the status line path in `settings.json`). Edit them
to match your setup.
