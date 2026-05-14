<div align="center">

# 🌿 Hyprland Dots

**Everforest-themed Hyprland rice for Arch Linux**

![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-58E1FF?style=for-the-badge&logo=wayland&logoColor=black)
![License](https://img.shields.io/badge/License-MIT-A7C080?style=for-the-badge)

</div>

---

## 🗂 Configs Included

| App | Role |
|-----|------|
| [Hyprland](https://hyprland.org/) | Window manager |
| [Hyprlock](https://github.com/hyprwm/hyprlock) | Lock screen |
| [Hyprpaper](https://github.com/hyprwm/hyprpaper) | Wallpaper daemon |
| [Hypridle](https://github.com/hyprwm/hypridle) | Idle daemon |
| [Waybar](https://github.com/Alexays/Waybar) | Status bar |
| [Kitty](https://sw.kovidgoyal.net/kitty/) | Terminal |
| [Wofi](https://hg.sr.ht/~scoopta/wofi) | App launcher |
| [Wlogout](https://github.com/ArtsyMacaw/wlogout) | Logout menu |
| [Dunst](https://dunst-project.org/) | Notifications |
| [Neovim](https://neovim.io/) | Text editor (NvChad) |
| [EasyEffects](https://github.com/wwmm/easyeffects) | Mic EQ (Blue Snowball) |
| [MPV](https://mpv.io/) | Media player |
| [Starship](https://starship.rs/) | Shell prompt |
| [Neofetch](https://github.com/dylanaraps/neofetch) | System info |
| [ncspot](https://github.com/hrkfdn/ncspot) | Terminal Spotify client |

---

## 📦 Dependencies

### Pacman
```bash
sudo pacman -S hyprland hyprpaper hyprlock hypridle xdg-desktop-portal-hyprland \
  waybar wofi dunst kitty neovim starship neofetch mpv dolphin \
  pipewire pipewire-pulse wireplumber easyeffects satty \
  ttf-jetbrains-mono-nerd ttf-iosevka-nerd noto-fonts noto-fonts-emoji \
  qt5ct qt6ct gtk3 gtk4 cava swayosd rsync
```

### AUR (via yay)
```bash
yay -S hyprshot matugen wlogout ncspot yt-x
```

### Fonts used
- **JetBrains Mono Nerd Font** — terminal, clock, UI text
- **Iosevka Nerd Font** — icons and symbols

---

## 🚀 Install

```bash
git clone https://github.com/UrTexts/Hyprland-dots.git ~/dotfiles
cd ~/dotfiles
bash install.sh
```

The install script will:
- Detect your distro (Arch or Fedora)
- Install all required packages
- Symlink configs to `~/.config/`
- Install Everforest cursor themes
- Enable PipeWire services
- Add Starship to your `.zshrc`

> Existing configs are backed up with a `.bak` extension — nothing gets deleted.

---

## 🔄 Syncing (Arch only)

If you want to sync changes back to the repo:

```bash
bash sync.sh
```

---

## 🎨 Colorscheme

[Everforest](https://github.com/sainnhe/everforest) dark — colors managed via [matugen](https://github.com/InioX/matugen).

| Role | Hex |
|------|-----|
| Background | `#1E2326` |
| Foreground | `#D3C6AA` |
| Accent (green) | `#A7C080` |
| Red | `#E67E80` |
| Surface | `#272E33` |

---

## 📝 Notes

- Wallpaper lives at `~/.config/Ghibli.png`
- If using SDDM with the `matugen-minimal` theme, copy the wallpaper manually:
  ```bash
  sudo cp ~/.config/Ghibli.png /usr/share/sddm/themes/matugen-minimal/wallpaper.jpg
  ```
- EasyEffects autostarts via `~/.config/autostart/`
- Neovim uses [NvChad](https://nvchad.com/) as a base
