# HHKB keyboard

HHKB Professional Hybrid, US layout, connected by Bluetooth (paired as `HHKB-Hybrid_1`, marked trusted with `bluetoothctl`) or USB. The full manual is `hhkb-manual.pdf` (PFU P3PC-6641-01EN). Read it for pairing, the full Fn table and the DIP switches.

## Setup

- **Mac mode**, with DIP switches SW2, SW3 and SW5 ON, all others OFF. SW5 swaps Alt and ◇ on both sides, so the keys match their printed labels. ◇ works as Super.
- Switch modes with `Fn+Ctrl+M` (Mac) and `Fn+Ctrl+W` (Windows). Mac mode is needed because the volume keys only work there.
- The user wants keys to do what their labels say, so don't propose remaps that change a labelled key.

## Fn layer: what the computer can see

The HHKB handles **Fn itself and never sends it**. Only Fn combos that the keyboard turns into a real key can be bound in niri:

Mac-mode Fn layer, taken from the manual's table:

| HHKB keys | Sends | Used for |
|---|---|---|
| `Fn+A` / `Fn+S` / `Fn+D` | XF86AudioLowerVolume / RaiseVolume / Mute | volume (Mac mode only) |
| `Fn+F` | XF86Eject | play/pause music (niri bind → `dms ipc call mpris playPause`) |
| `Fn+[` / `Fn+/` / `Fn+;` / `Fn+'` | Up / Down / Left / Right | |
| `Fn+K` / `Fn+,` | Home / End | |
| `Fn+L` / `Fn+.` | Page Up / Page Down | |
| `Fn+I` | Print | niri `Print` screenshot binds |
| `Fn+O` / `Fn+P` | Scroll Lock / Pause | |
| `Fn+N` / `Fn+M` / `Fn+H` / `Fn+J` | keypad + − * / | free for binds; keypad keysyms are the same in both layouts |
| `Fn+1…=` | F1–F12 | |
| `Fn+`` ` | Delete | |
| `Fn+Esc` | Power | |

Combinations like `Fn+Z` send nothing on their own (Fn+Z+Delete deletes a pairing, Fn+Q starts pairing). Changing the Fn layer requires PFU's Keymap Tool, which only runs on Windows and macOS. Print exists only as `Fn+I`, so screenshots also have Fn-free binds on `Super+…+S`.

To check what a key sends: `wev`, or `dms keybinds keymap`.

## Keyboard layouts (xkb)

- **us-no** (custom): US with Norwegian letters on Right Alt (AltGr). `AltGr+[` = å, `AltGr+;` = ø, `AltGr+'` = æ, and Shift for capitals. Files:
  - `~/.config/xkb/symbols/us-no`, which builds on `us(basic)` + `level3(ralt_switch)`
  - `~/.config/xkb/rules/evdev.xml`, which registers it by name
  
  libxkbcommon picks both up from `~/.config/xkb`.
- **no**: standard Norwegian, for when the user is on a Norwegian keyboard.
- Left Alt stays a normal Alt (the user's choice). niri switches layouts with `Alt+Space` (left Alt only). See `niri.md` for how the active layout affects which binds work.
- Check that the layout file compiles:
  `xkbcomp -w0 -I$HOME/.config/xkb -I/usr/share/X11/xkb <keymap>.xkb out.xkm`
  where the keymap's `xkb_symbols` is `include "pc+us-no+no:2+inet(evdev)"`.
