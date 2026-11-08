# niri keybinds

The user's cheat sheet: it has to match `~/.config/niri/config.kdl`. Update it whenever a bind changes, and keep the modifier scheme below when choosing keys for new binds.

Setup: HHKB keyboard, vim-style navigation, more than one monitor.
Config: `~/.config/niri/config.kdl`. niri reloads it automatically when the file is saved.

> **Forgot a shortcut?** Press `Super + Alt + H` ("help") to show the overview. It works in both layouts.
> `Super + Shift + /` also works, but only on the us-no layout.

## The idea

Every desktop shortcut starts with **Super**. You add one or more modifiers to change *what kind* of action the key does. The letter says **where** or **what**; the modifiers say **how**.

### What each modifier means

| Modifier  | Role                    | In one sentence                                                                 |
|-----------|-------------------------|---------------------------------------------------------------------------------|
| **Super** | Main modifier ("desktop") | Every desktop shortcut starts with Super. On its own it **navigates**: it moves focus without changing anything. |
| **Shift** | Move                    | "Take it with me": the focused column/window **moves** in the direction you'd otherwise only look. |
| **Ctrl**  | Monitors                | "Other screen": the action happens **between monitors** instead of within one. |
| **Alt**   | Function / alternate    | "The bigger or other version": acts on the **whole workspace** instead of one column, jumps **all the way** (`Super+Alt+A/E` first/last column), or gives an **alternate function** of an action key (`Super+Alt+F` expand vs `Super+F` maximise). Also system functions: `Super+Alt+H` help, `Super+Alt+L` lock. |

The modifiers **combine**, and each keeps its meaning:

- `Ctrl` + `Shift` = move (Shift) to another monitor (Ctrl), so `Super+Ctrl+Shift+L` moves the column to the right monitor.
- `Ctrl` + `Alt` = the whole workspace (Alt) to another monitor (Ctrl), so `Super+Ctrl+Alt+L` moves the workspace to the right monitor.

A few shortcuts work without Super: `Alt+Space` (keyboard layout), `Ctrl+Alt+Delete` (quit), the Print keys and the media keys.

### Combinations at a glance

| Modifier            | Meaning                                                      | Example                                   |
|---------------------|--------------------------------------------------------------|-------------------------------------------|
| `Super`             | **Navigate**: move focus                                     | `Super+L` → focus the column to the right |
| `Super+Shift`       | **Move** the focused column/window the same way              | `Super+Shift+L` → move column right       |
| `Super+Ctrl`        | **Monitors**: focus another monitor                          | `Super+Ctrl+L` → focus the right monitor  |
| `Super+Ctrl+Shift`  | Move the **column** to another monitor                       | `Super+Ctrl+Shift+L`                      |
| `Super+Ctrl+Alt`    | Move the **whole workspace** to another monitor              | `Super+Ctrl+Alt+L`                        |
| `Super+Alt`         | **Whole workspace** (reorder), or an alternate version of an action | `Super+Alt+U` → move workspace down |

Direction keys are vim-style and need no Fn on the HHKB:

- `H` / `L`: left / right (columns)
- `J` / `K`: down / up (windows in a column, then workspaces)
- `U` / `I`: workspace down / up
- `Alt` + `A` / `E`: first / last column (like `Ctrl+A` / `Ctrl+E` in the shell)
- `1`–`9`: workspace by number

The arrow keys, PageUp/PageDown and Home/End also work in the same places. On the HHKB they need Fn, so they're only fallbacks.

On "action" keys (F, R, V, S, −/=), `Shift` gives a stronger or alternate variant, for example `Super+F` maximise vs `Super+Shift+F` fullscreen.

---

## Navigate and move (current monitor)

| Keys                        | Action                                                        |
|-----------------------------|---------------------------------------------------------------|
| `Super+H` / `Super+L`       | Focus the column left / right                                 |
| `Super+J` / `Super+K`       | Focus the window down / up, then the next workspace at the end |
| `Super+Shift+H` / `Super+Shift+L` | Move the column left / right                            |
| `Super+Shift+J` / `Super+Shift+K` | Move the window down / up, then to the next workspace at the end |
| `Super+Alt+A` / `Super+Alt+E` | Focus the first / last column                               |
| `Super+Alt+Shift+A` / `Super+Alt+Shift+E` | Move the column to first / last place           |
| `Super+[` / `Super+]`       | Pull the window into the column to its left / right, or push it out |
| `Super+,`                   | Pull the window on the right into this column                 |
| `Super+.`                   | Push the bottom window out of this column                     |
| `Super+O`                   | Overview (zoomed-out view of all workspaces)                  |

## Workspaces

| Keys                          | Action                                     |
|-------------------------------|--------------------------------------------|
| `Super+U` / `Super+I`         | Focus the workspace down / up              |
| `Super+1` … `Super+9`         | Go to workspace N                          |
| `Super+Shift+U` / `Super+Shift+I` | Move the column to the workspace down / up |
| `Super+Shift+1` … `9`         | Move the column to workspace N             |
| `Super+Alt+U` / `Super+Alt+I` | Reorder: move the whole workspace down / up |

## Monitors

| Keys                               | Action                                       |
|------------------------------------|----------------------------------------------|
| `Super+Ctrl+H/J/K/L`               | Focus the monitor left / down / up / right   |
| `Super+Ctrl+Shift+H/J/K/L`         | Move the column to that monitor              |
| `Super+Ctrl+Alt+H/J/K/L`           | Move the whole workspace to that monitor     |
| `Super+Ctrl+P`                     | Turn off the monitors (any input wakes them) |

"Left/right" follows the monitor `position` in the outputs config (`dms/outputs.kdl`), not where the screens physically sit on your desk. `niri msg outputs` lists the monitor names.

## Window size and layout

| Keys                        | Action                                              |
|-----------------------------|-----------------------------------------------------|
| `Super+R` / `Super+Shift+R` | Cycle through preset column widths (forward / back) |
| `Super+Alt+R`               | Reset the window height                             |
| `Super+Alt+Shift+R`         | Cycle through preset window heights                 |
| `Super+−` / `Super+=`       | Column width −10% / +10%                            |
| `Super+Shift+−` / `Super+Shift+=` | Window height −10% / +10%                     |
| `Super+F`                   | Maximise the column (keeps the gaps)                |
| `Super+Shift+F`             | Fullscreen                                          |
| `Super+Alt+F`               | Expand the column to fill the free space            |
| `Super+M`                   | Maximise the window to the screen edges             |
| `Super+C`                   | Centre the column                                   |
| `Super+Alt+C`               | Centre all visible columns                          |
| `Super+W`                   | Show the column as tabs                             |
| `Super+V`                   | Toggle floating / tiling                            |
| `Super+Shift+V`             | Switch focus between floating and tiling windows    |

## Apps and system

| Keys                 | Action                                          |
|----------------------|-------------------------------------------------|
| `Super+Space`        | App launcher (fuzzel); `Super+D` works too       |
| `Super+T`            | Terminal (alacritty)                            |
| `Super+B`            | Default web browser                             |
| `Super+E`            | Default file manager (opens your home folder)   |
| `Super+Return`       | Terminal (alacritty, from DMS)                  |
| `Super+Q`            | Close the window                                |
| `Super+Alt+H`        | Show the shortcut overview (both layouts)       |
| `Super+Shift+/`      | Show the shortcut overview (us-no layout only)  |
| `Super+Alt+L`        | Lock the screen                                 |
| `Super+Escape`       | Turn shortcut inhibiting on/off (escape hatch for remote-desktop apps) |
| `Ctrl+Alt+Delete`    | Quit niri (asks for confirmation)               |
| `Super+Alt+S`        | Turn the orca screen reader on/off              |

## Keyboard layout

| Keys          | Action                                                 |
|---------------|--------------------------------------------------------|
| `Alt+Space`   | Switch layout: **us-no** ⇄ **Norwegian**               |

- **us-no** is US with æøå on Right Alt: `RAlt+[` = å, `RAlt+;` = ø, `RAlt+'` = æ.
- Use **left** Alt for `Alt+Space`. Right Alt is AltGr in both layouts.
- `niri msg keyboard-layouts` shows the active layout (marked with `*`).
- Shortcuts follow the character a key types in the **active** layout. Letters, numbers, Space, `,` and `.` work in both layouts. On the Norwegian layout `Super+Shift+/`, `Super+[` / `Super+]` and `Super+=` can't be reached, and `Super+−` is on a different key.
- DMS keyboard settings (`dms/input.kdl`) can override the layouts in `config.kdl`. If switching stops working, check there first.

## Screenshots

On the HHKB, Print is `Fn+I`, so all screenshots also have Fn-free binds on `S`:

| Keys                  | Action                     |
|-----------------------|----------------------------|
| `Super+Shift+S`       | Screenshot a selected area |
| `Super+Ctrl+Shift+S`  | Screenshot the whole screen |
| `Super+Alt+Shift+S`   | Screenshot the current window |
| `Print` / `Ctrl+Print` / `Alt+Print` | Area / screen / window (HHKB: `Fn+I`) |

## Mouse

| Keys                              | Action                              |
|-----------------------------------|-------------------------------------|
| `Super+Scroll`                    | Switch workspace                    |
| `Super+Shift+Scroll`              | Move the column to the next/previous workspace |
| `Super+Scroll left/right`         | Focus column left / right           |
| `Super+Shift+Scroll left/right`   | Move column left / right            |

## Media keys (HHKB Mac mode)

| Keys (HHKB)  | Action                    |
|--------------|---------------------------|
| `Fn+A`       | Volume down               |
| `Fn+S`       | Volume up                 |
| `Fn+D`       | Mute                      |
| `Fn+F`       | **Play / pause music** (the HHKB's Eject key) |
| `Fn+Esc`     | Nothing (power key disabled with a no-op bind on `XF86PowerOff`) |

These work even when the screen is locked. Play/pause, next, previous and stop keys on other keyboards also control the music, through DMS (`dms ipc call mpris …`), with any MPRIS player such as Spotify.

The HHKB handles `Fn` itself and never sends it to the computer, so only the Fn combinations above can be bound.

## Default apps

`Super+B` and `Super+E` don't name a program: they ask xdg for the current default, so changing the default needs no niri edit.

- Browser: `xdg-settings get default-web-browser` (now Brave). Change: `xdg-settings set default-web-browser <app>.desktop`.
- File manager: the handler for `inode/directory`, `xdg-mime query default inode/directory` (now Thunar). Change: `xdg-mime default <app>.desktop inode/directory`.
- Both are stored in `~/.config/mimeapps.list` (under `[Default Applications]`). The app names are `.desktop` files in `/usr/share/applications` or `~/.local/share/applications`.
