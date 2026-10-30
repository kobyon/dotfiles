# DankMaterialShell (DMS)

DMS v2.0.0 draws the bar, launcher, control centre, lock screen, and so on. It runs as `dms run --session` (Quickshell UI under `/usr/share/quickshell/dms/quickshell`).

## Where its settings live

- `~/.config/DankMaterialShell/settings.json` is the source of truth for everything set in the DMS settings window. Keys include `barConfigs`, `mouseAccelSpeed`, `mouseAccelProfile`, `keyboardTrackLayout`, `keyboardRepeatRate` and `cursorSettings`.
- From those settings DMS **generates** niri snippets in `~/.config/niri/dms/*.kdl`. Each one is headed "DO NOT EDIT" and gets overwritten. To change one, change the setting in DMS, or override it in `config.kdl`; an override only wins if it comes *after* the include, or if DMS doesn't set that field.
  - `outputs.kdl`: monitor modes and positions (DP-5, DP-9, DP-7, then the laptop eDP-1, left to right).
  - `input.kdl`: mouse, touchpad and keyboard settings. Watch for two things here:
    - If DMS writes an `xkb { }` block, it wipes the `us-no,no` layouts.
    - If DMS writes `options "grp:win_space_toggle"`, Super+Space both switches layout and opens the launcher.
    
    Both have happened before. The fix is to clear the keyboard-layout options in DMS settings.
  - `binds.kdl`: `Mod+Return` → alacritty. `windowrules.kdl`: DMS's own windows open floating.
- Open the settings window: `dms ipc call settings open` or `dms ipc call settings openWith <tab>`.

## IPC and CLI

`dms ipc call <target> <function> [args]`. The handlers are defined in `/usr/share/quickshell/dms/quickshell/DMSShellIPC.qml`; read that file to find a target's functions.

| Purpose | Command |
|---|---|
| Media (no playerctl on this machine) | `dms ipc call mpris playPause` / `next` / `previous` / `stop` / `list` |
| Settings window | `dms ipc call settings open` |
| Set one setting | `dms ipc call settings set <key> <value>` |
| Bar widget catalog | `/usr/share/quickshell/dms/quickshell/Common/BarWidgetCatalog.qml` |
| Show niri binds | `dms keybinds show niri` |
| Which keysym a key sends | `dms keybinds keymap` |
| Restart the shell | `dms restart` |

## Bar widgets in use or discussed

- Keyboard layout indicator: widget id `keyboard_layout_name`, normally in the right section. Its "compact mode" shows a short code instead of "English (US, Norwegian æøå on AltGr)". It's added through the settings window.
