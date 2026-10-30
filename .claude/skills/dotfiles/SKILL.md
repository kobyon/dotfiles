---
name: dotfiles
description: Manage and document the user's Linux desktop and dotfiles. Use this whenever the user mentions niri (config, keybinds, workspaces, monitors, the help overlay), DankMaterialShell / DMS (bar, widgets, settings, dms ipc), keyboard layouts (us-no / Norwegian, æøå), the HHKB keyboard (Fn keys, DIP switches, media keys), mouse or input settings, or syncing/committing config files to the dotfiles repo — even if they just say "my desktop", "the bar", "a shortcut" or "my keyboard".
---

# dotfiles

The user's desktop: **niri** (Wayland compositor) + **DankMaterialShell** (bar/shell), driven from an **HHKB** keyboard. Configs live in `$HOME` and are mirrored into the repo `~/projects/dotfiles`.

Read only the reference you need:

| Topic | Reference |
|---|---|
| Repo layout, syncing, git/commit rules | `references/repo.md` |
| niri config, includes, validation, gotchas | `references/niri.md` |
| Every keybind + the modifier scheme | `references/niri-keybinds.md` |
| DMS: generated files, settings, IPC, widgets | `references/dankshell.md` |
| HHKB keyboard, Fn layer, us-no xkb layout | `references/hhkb.md` (manual: `references/hhkb-manual.pdf`) |

## Workflow for changes

1. Check the live file first — the user also edits by hand. For a new bind: confirm the key is free (duplicate check in niri.md), fits the modifier scheme, and that the program it launches is installed (`command -v`). If you had to pick the key yourself, propose it and let the user choose.
2. Edit the live file in `$HOME` (never DMS-generated files — see dankshell.md), then validate: `niri validate -c ~/.config/niri/config.kdl` (niri auto-reloads on save).
3. Update the matching reference so the docs match the config. Keybind changes always update `niri-keybinds.md` — it is the user's cheat sheet. This skill folder *is* in the repo, so reference edits need no copying.
4. Copy changed `$HOME` files into the repo and stage them (see repo.md).
5. Commit or push only when the user asks.

These references are the documentation. When a new area of the dotfiles comes up, add a new `references/<topic>.md` and a row above, rather than growing this file.
