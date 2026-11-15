# niri

Version 26.04. Config: `~/.config/niri/config.kdl`. All keybinds are listed in `niri-keybinds.md`.

## Structure

- `config.kdl` is niri's default config, customised. Sections: `input`, `output`, `layout`, `spawn-at-startup`, `window-rule`, `binds`.
- At the bottom it includes DMS-generated files, in this order:
  ```
  include optional=true "dms/outputs.kdl"
  include optional=true "dms/windowrules.kdl"
  include optional=true "dms/binds.kdl"
  include optional=true "dms/input.kdl"
  ```
  Later wins (DMS `binds.kdl` only adds `Mod+Return`). Inside `input`, most fields merge one by one, but a whole `xkb { }` block **replaces** an earlier one. If DMS ever writes `xkb { … }` into `dms/input.kdl`, your `layout "us-no,no"` disappears. See `dankshell.md`.
- `binds` is laid out by the modifier scheme: navigate, then move (Shift), monitors (Ctrl), workspace (Alt). Each letter bind comes first and carries the `hotkey-overlay-title`. Arrow/Page/Home/End fallbacks follow without titles.
- Where new binds go: app launchers next to `Mod+T` / `Mod+Space` near the top of `binds`; media and hardware keys (`XF86…`) in the media block below; window and layout actions in the section their modifier belongs to. Give every bind the user should discover a `hotkey-overlay-title`.
- Free keys: run `dms keybinds show niri`, or grep the binds, before choosing. As of 2026-10, the free letters with plain Super include `A`, `G`, `N`, `P`, `S`, `X`, `Y`, `Z` (`B` = browser, `E` = file manager). Re-check, since the user changes binds.

## Commands

| Task | Command |
|---|---|
| Validate after every edit | `niri validate -c ~/.config/niri/config.kdl` |
| Reload | automatic on save |
| Active keyboard layout | `niri msg keyboard-layouts` (`*` marks the active one) |
| Monitor names/positions | `niri msg outputs` |
| Run any action | `niri msg action <action>` |
| Binds as DMS sees them | `dms keybinds show niri` |

`niri validate` does **not** catch duplicate keys: the same key bound twice is valid, and one of them silently loses. After editing binds, check:

```bash
grep -hE '^\s*(Mod|Super|Alt|Ctrl|Shift|Print|XF86)\S*\s' ~/.config/niri/config.kdl ~/.config/niri/dms/binds.kdl \
  | awk '{print $1}' | sed 's/^Super+/Mod+/' | tr A-Z a-z | sort | uniq -d
```

`Mod` = Super here.

## Gotchas

- **Binds match the keysym in the *active* layout.** The user switches between us-no and Norwegian (`Alt+Space`). On Norwegian:
  - `/` is Shift+7, so `Mod+Shift+Slash` can't be reached. `Mod+Alt+H` is the layout-neutral help bind.
  - `[`, `]` and `=` are AltGr/Shift combos, so `Mod+BracketLeft/Right` and `Mod+Equal` can't be reached.
  - `+` and `-` are their own keys (`Plus`, `Minus`).
  
  Letters, digits, Space, Comma and Period behave the same in both layouts. When adding a bind on a symbol key, consider a letter instead, or an extra bind for the Norwegian keysym.
- **Right Alt is AltGr** in both layouts (æøå), so `Alt+…` binds only fire with left Alt.
- **xkb layout switching:** use niri's `switch-layout` bind (`Alt+Space`), not an xkb `grp:` option. Having both makes one key switch twice.
- **HHKB:** arrows, PageUp/Down and Home/End need Fn. Prefer letter keys. The HHKB never sends Fn itself (see `hhkb.md`).
- **`playerctl` is not installed.** Media binds use `dms ipc call mpris playPause|next|previous|stop`.
- Nothing is spawned at startup for the bar: DMS runs from its systemd user service `dms.service` (`WantedBy=graphical-session.target`), which the dotfiles role enables.

## Default apps

Launch the user's default app through xdg instead of naming a program, so the bind follows the default: browser `gtk-launch "$(xdg-settings get default-web-browser)"`, file manager `xdg-open ~` (handler for `inode/directory`). Defaults live in `~/.config/mimeapps.list`; see the "Default apps" section in `niri-keybinds.md`.

## Input

- Keyboard: `layout "us-no,no"` (custom us-no first), `numlock`. DMS adds `track-layout "global"` and `repeat-rate 40`.
- Mouse: `accel-profile "flat"` (no acceleration) and `accel-speed -0.1`, set in config.kdl. DMS also writes `accel-speed`/`accel-profile` from its settings, and its include is loaded last, so a change in the DMS settings window wins.
- Touchpad (DMS): tap, natural-scroll, dwt.
