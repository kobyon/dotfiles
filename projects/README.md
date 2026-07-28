# Projects Layout

## Structure

```
projects/
├── sakkenix/          ← namespace (private repos)
├── upheads/           ← namespace (private repos)
├── cloned/            ← namespace (public / third-party clones)
├── ws-<name>/         ← workspace (a working context)
└── ws-<name>.code-workspace
```

## Concepts

**Namespace folders** (`sakkenix`, `upheads`, `cloned`)
Home of the actual git repositories. One clone per repo, kept here permanently.
Never open these directly in VS Code.

**Workspaces** (`ws-<name>/`)
A working context that composes repos from the namespaces. Each workspace has
a matching single-root `ws-<name>.code-workspace` file at the project root.

## Creating a New Workspace

1. Create the workspace folder:
   ```
   mkdir ws-myproject
   ```

2. Populate it with repos, using one of two mechanisms:

   **Symlink** — when you want the repo's default branch, shared across workspaces:
   ```
   cd ws-myproject
   ln -s ../sakkenix/somerepo .
   ```

   **Worktree** — when you need an isolated branch for this workspace:
   ```
   cd sakkenix/somerepo
   git worktree add ../../ws-myproject/somerepo -b feature/x
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
- Never clone a repo directly into a `ws-*` folder — clone into the namespace,
  then symlink or worktree from there.
- Keep workspace files minimal: just `folders`. Editor settings live in the
  repo or user settings, not the workspace file.
