# Projects Layout

## Structure

```
projects/
├── <repo>/             ← repos you have direct access to, cloned at top level
├── cloned/              ← namespace (repos you don't have direct access to / third-party)
├── ws-<name>/           ← workspace (a working context)
└── ws-<name>.code-workspace
```

## Concepts

**Top-level repos**
Repos you have direct access to are cloned directly here, one folder per repo
(e.g. `ansible/`, `control/`, `finna/`). There are no namespace folders
anymore — the repo folder name is the repo name. Never open these directly
in VS Code.

**`cloned/`**
Repos you don't have direct access to (public / third-party / read-only
clones). Same rule applies: never open these directly in VS Code.

**Workspaces** (`ws-<name>/`)
A working context that composes repos from the top-level and `cloned/`
folders. Each workspace has a matching single-root `ws-<name>.code-workspace`
file at the project root.

## Creating a New Workspace

1. Create the workspace folder:
   ```
   mkdir ws-myproject
   ```

2. Populate it with repos, using one of two mechanisms:

   **Symlink** — when you want the repo's default branch, shared across workspaces:
   ```
   cd ws-myproject
   ln -s ../somerepo .
   ```

   **Worktree** — when you need an isolated branch for this workspace:
   ```
   cd somerepo
   git worktree add ../ws-myproject/somerepo -b feature/x
   ```

3. Create the workspace file `ws-myproject.code-workspace`:
   ```json
   {
       "folders": [
           { "path": "ws-myproject" }
       ]
   }
   ```

4. Open it in VS Code.

## Rules of Thumb

- Symlink = shared checkout, changes visible everywhere.
- Worktree = isolated branch, own working tree, own state.
- Never clone a repo directly into a `ws-*` folder — clone it at the top
  level (or into `cloned/` if you don't have direct access), then symlink
  or worktree from there.
- Keep workspace files minimal: just `folders`. Editor settings live in the
  repo or user settings, not the workspace file.
