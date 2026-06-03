# Git

## Aliases

| Alias     | Command                                | Description                              |
|-----------|----------------------------------------|------------------------------------------|
| `a`       | `add`                                  | Stage files                              |
| `acdp`    | `add . && commit -s && push`           | Stage all, date-commit, push             |
| `b`       | `branch`                               | List/manage branches                     |
| `c`       | `commit -s`                            | Signed-off commit                        |
| `cd`      | `commit -s -m "$(date)"`               | Commit with current date as message      |
| `cdp`     | `commit -s -m "$(date)"; push`         | Date-commit and push                     |
| `cleanup` | `fetch --prune && delete merged`       | Delete local branches merged into `main` |
| `co`      | `checkout`                             | Switch branches                          |
| `d`       | `diff HEAD` (word-diff, custom format) | Compact word-level diff against HEAD     |
| `dm`      | `diff main` (word-diff, custom format) | Compact word-level diff against `main`   |
| `l`       | `log --graph --abbrev-commit`          | Colorized one-line graph log             |
| `s`       | `status --ignored`                     | Status including ignored files           |
| `sh`      | `show HEAD`                            | Show last commit                         |

The `d` and `dm` aliases use `awk` to strip `index`/`---`/`+++` noise and simplify `diff --git` headers, then pipe through `less -RFX`.

## Signing

Commits and tags are signed using **SSH keys** (`gpg.format = ssh`).

## Hooks

Global hooks are enabled via `core.hooksPath = ~/.config/git/hooks`.

### pre-commit

Runs [gitleaks](https://github.com/gitleaks/gitleaks) on staged files to block secrets from being committed. Falls back to running gitleaks inside the default toolbox container if not available on the host. Aborts the commit if gitleaks is not found.

### commit-msg

Appends gitleaks version and scan status to the commit message trailer.

## Merge & pull

| Setting                  | Value            | Effect                                     |
|--------------------------|------------------|--------------------------------------------|
| `branch.sort`            | -committerdate   | List most recently used branches first     |
| `diff.algorithm`         | histogram        | Better diffs for moved code blocks         |
| `fetch.prune`            | true             | Auto-remove stale remote-tracking branches |
| `merge.conflictstyle`    | zdiff3           | Shows base version in conflict markers     |
| `pull.rebase`            | true             | Rebase instead of merge on pull            |
| `push.autoSetupRemote`   | true             | Auto-track remote branch on first push     |
| `rebase.autoStash`       | true             | Auto-stash before rebase, pop after        |
| `rerere.enabled`         | true             | Remember and reuse conflict resolutions    |
