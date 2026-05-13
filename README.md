# hyprland-dots

my hyprland config — everforest theme

## components

| config | program |
|--------|---------|
| `hypr/` | [hyprland](https://hyprland.org) — compositor + keybinds |
| `waybar/` | [waybar](https://github.com/Alexays/Waybar) — status bar |
| `wofi/` | [wofi](https://hg.sr.ht/~scoopta/wofi) — app launcher |
| `kitty/` | [kitty](https://sw.kovidgoyal.net/kitty) — terminal |
| `mpv/` | [mpv](https://mpv.io) — media player |
| `starship.toml` | [starship](https://starship.rs) — shell prompt |

## install

```bash
git clone https://github.com/UrTexts/Hyprland-dots.git
cp -r Hyprland-dots/config/* ~/.config/
```

### dependencies

**arch**
```bash
sudo pacman -S hyprland waybar wofi kitty mpv starship
```

**fedora**
```bash
sudo dnf install hyprland waybar wofi kitty mpv
cargo install starship  # or use the install script
```

## wallpaper

`Ghibli.png` — set it with hyprpaper or swww
