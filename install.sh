#!/bin/bash
# ============================================================
#  Dotfiles Install Script — Hyprland/Everforest Setup
#  Run from inside ~/dotfiles
# ============================================================

set -e

DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG="$DOTFILES/config"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Dotfiles Installer"
echo "  Dotfiles dir: $DOTFILES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# ── Helpers ──────────────────────────────────────────────────
confirm() {
    read -rp "$1 [y/N] " ans
    [[ "$ans" =~ ^[Yy]$ ]]
}

backup_and_link() {
    local src="$1"
    local dest="$2"
    mkdir -p "$(dirname "$dest")"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "  → Backing up existing $(basename "$dest") to $dest.bak"
        mv "$dest" "$dest.bak"
    fi
    ln -sf "$src" "$dest"
    echo "  ✓ Linked $dest"
}

# ── 1. Detect distro ─────────────────────────────────────────
echo ""
echo "▶ Detecting distro..."

if command -v pacman &>/dev/null; then
    DISTRO="arch"
    echo "  Detected: Arch Linux"
elif command -v dnf &>/dev/null; then
    DISTRO="fedora"
    echo "  Detected: Fedora"
else
    echo "  ✗ Unsupported distro — only Arch and Fedora are supported."
    exit 1
fi

# ── 2. Install packages ───────────────────────────────────────
echo ""
echo "▶ Installing packages..."

if [ "$DISTRO" = "arch" ]; then

    PACMAN_PKGS=(
        hyprland
        hyprpaper
        hyprlock
        hypridle
        xdg-desktop-portal-hyprland
        waybar
        wofi
        dunst
        kitty
        neovim
        starship
        neofetch
        mpv
        dolphin
        pipewire
        pipewire-pulse
        wireplumber
        easyeffects
        satty
        ttf-jetbrains-mono-nerd
        ttf-iosevka-nerd
        noto-fonts
        noto-fonts-emoji
        qt5ct
        qt6ct
        gtk3
        gtk4
        cava
        swayosd
    )

    AUR_PKGS=(
        hyprshot
        matugen
        ncspot
        yt-x
        wlogout
    )

    echo "  Installing pacman packages..."
    sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

    if command -v yay &>/dev/null; then
        echo "  Installing AUR packages with yay..."
        yay -S --needed --noconfirm "${AUR_PKGS[@]}"
    else
        echo "  ⚠ yay not found — skipping AUR packages: ${AUR_PKGS[*]}"
        echo "    Install yay first, then re-run for: ${AUR_PKGS[*]}"
    fi

elif [ "$DISTRO" = "fedora" ]; then

    # Enable COPR repos for packages not in default Fedora repos
    echo "  Enabling COPR repos..."
    sudo dnf copr enable -y solopasha/hyprland 2>/dev/null || \
        echo "  ⚠ hyprland COPR already enabled or failed"
    sudo dnf copr enable -y erikreider/SwayNotificationCenter 2>/dev/null || true

    DNF_PKGS=(
        hyprland
        hyprpaper
        hyprlock
        hypridle
        xdg-desktop-portal-hyprland
        waybar
        wofi
        dunst
        kitty
        neovim
        starship
        neofetch
        mpv
        dolphin
        pipewire
        pipewire-pulseaudio
        wireplumber
        easyeffects
        satty
        jetbrains-mono-fonts
        iosevka-nerd-fonts
        google-noto-fonts-common
        google-noto-emoji-fonts
        qt5ct
        qt6ct
        gtk3
        gtk4
        cava
    )

    # Fedora packages not available or named differently — install manually after
    FEDORA_MANUAL=(
        "hyprshot   → not in repos, build from source: https://github.com/Gustash/hyprshot"
        "matugen    → not in repos, build from source: https://github.com/InioX/matugen"
        "wlogout    → not in repos, build from source: https://github.com/ArtsyMacaw/wlogout"
        "ncspot     → not in repos, install via cargo: cargo install ncspot"
        "yt-x       → not in repos, check: https://github.com/Yttehs-HDX/yt-x"
        "swayosd    → not in repos, build from source: https://github.com/ErikReider/SwayOSD"
    )

    echo "  Installing dnf packages..."
    sudo dnf install -y "${DNF_PKGS[@]}"

    echo ""
    echo "  ⚠ The following packages need manual install on Fedora:"
    for pkg in "${FEDORA_MANUAL[@]}"; do
        echo "    • $pkg"
    done

fi

# ── 3. Link configs ───────────────────────────────────────────
echo ""
echo "▶ Linking config files..."

# Hyprland
backup_and_link "$CONFIG/hypr/hyprland.conf"    "$HOME/.config/hypr/hyprland.conf"
backup_and_link "$CONFIG/hypr/hyprpaper.conf"   "$HOME/.config/hypr/hyprpaper.conf"
backup_and_link "$CONFIG/hypr/hyprlock.conf"    "$HOME/.config/hypr/hyprlock.conf"
backup_and_link "$CONFIG/hypr/hypridle.conf"    "$HOME/.config/hypr/hypridle.conf"
backup_and_link "$CONFIG/hypr/autostart.sh"     "$HOME/.config/hypr/autostart.sh"
chmod +x "$CONFIG/hypr/autostart.sh"

# Hypr scripts
mkdir -p "$HOME/.config/hypr/scripts"
backup_and_link "$CONFIG/hypr/scripts/hyprlock.sh" "$HOME/.config/hypr/scripts/hyprlock.sh"
chmod +x "$CONFIG/hypr/scripts/hyprlock.sh"

# Waybar
backup_and_link "$CONFIG/waybar/config.jsonc"   "$HOME/.config/waybar/config.jsonc"
backup_and_link "$CONFIG/waybar/style.css"      "$HOME/.config/waybar/style.css"

# Kitty
backup_and_link "$CONFIG/kitty/kitty.conf"          "$HOME/.config/kitty/kitty.conf"
backup_and_link "$CONFIG/kitty/everforrest.conf"     "$HOME/.config/kitty/everforrest.conf"
backup_and_link "$CONFIG/kitty/current-theme.conf"   "$HOME/.config/kitty/current-theme.conf"

# Wofi
backup_and_link "$CONFIG/wofi/style.css"        "$HOME/.config/wofi/style.css"

# Wlogout
backup_and_link "$CONFIG/wlogout/layout"        "$HOME/.config/wlogout/layout"
backup_and_link "$CONFIG/wlogout/style.css"     "$HOME/.config/wlogout/style.css"
backup_and_link "$CONFIG/wlogout/colors.css"    "$HOME/.config/wlogout/colors.css"
# Wlogout icons
mkdir -p "$HOME/.config/wlogout/icons"
for icon in "$CONFIG/wlogout/icons/"*; do
    backup_and_link "$icon" "$HOME/.config/wlogout/icons/$(basename "$icon")"
done

# Dunst
backup_and_link "$CONFIG/dunst/dunstrc"         "$HOME/.config/dunst/dunstrc"

# Neovim
backup_and_link "$CONFIG/nvim"                  "$HOME/.config/nvim"

# Starship
backup_and_link "$CONFIG/starship.toml"         "$HOME/.config/starship.toml"

# Neofetch
backup_and_link "$CONFIG/neofetch/config.conf"  "$HOME/.config/neofetch/config.conf"

# MPV
backup_and_link "$CONFIG/mpv/mpv.conf"          "$HOME/.config/mpv/mpv.conf"
backup_and_link "$CONFIG/mpv/script-opts/osc.conf" "$HOME/.config/mpv/script-opts/osc.conf"
backup_and_link "$CONFIG/mpv/scripts/oscc.lua"  "$HOME/.config/mpv/scripts/oscc.lua"
mkdir -p "$HOME/.config/mpv/fonts"
backup_and_link "$CONFIG/mpv/fonts/oscc.ttf"    "$HOME/.config/mpv/fonts/oscc.ttf"

# EasyEffects
backup_and_link "$CONFIG/easyeffectsrc"         "$HOME/.config/easyeffectsrc"
mkdir -p "$HOME/.config/easyeffects/db"
for f in "$CONFIG/easyeffects/db/"*; do
    backup_and_link "$f" "$HOME/.config/easyeffects/db/$(basename "$f")"
done
# EasyEffects autostart
mkdir -p "$HOME/.config/autostart"
backup_and_link "$CONFIG/autostart/com.github.wwmm.easyeffects.desktop" \
    "$HOME/.config/autostart/com.github.wwmm.easyeffects.desktop"

# Cava
if [ -d "$CONFIG/cava" ]; then
    backup_and_link "$CONFIG/cava" "$HOME/.config/cava"
fi

# Qt theming
backup_and_link "$CONFIG/qt5ct" "$HOME/.config/qt5ct" 2>/dev/null || true
backup_and_link "$CONFIG/qt6ct" "$HOME/.config/qt6ct" 2>/dev/null || true

# ncspot
backup_and_link "$CONFIG/ncspot/config.toml"    "$HOME/.config/ncspot/config.toml"

# yt-x
backup_and_link "$CONFIG/yt-x/config"           "$HOME/.config/yt-x/config"

# Wallpaper
if [ -f "$CONFIG/Ghibli.png" ]; then
    backup_and_link "$CONFIG/Ghibli.png"        "$HOME/.config/Ghibli.png"
    echo "  ✓ Wallpaper linked"
fi

# ── 4. Cursors ────────────────────────────────────────────────
echo ""
echo "▶ Installing Everforest cursors..."

mkdir -p "$HOME/.icons"
for cursor_dir in "$DOTFILES/.icons/"*/; do
    name="$(basename "$cursor_dir")"
    if [ -e "$HOME/.icons/$name" ] && [ ! -L "$HOME/.icons/$name" ]; then
        mv "$HOME/.icons/$name" "$HOME/.icons/$name.bak"
    fi
    ln -sf "$cursor_dir" "$HOME/.icons/$name"
    echo "  ✓ Cursor theme: $name"
done

# Set default cursor
backup_and_link "$DOTFILES/.icons/default/index.theme" "$HOME/.icons/default/index.theme"

# ── 5. Enable systemd services ────────────────────────────────
echo ""
echo "▶ Enabling user systemd services..."

systemctl --user enable --now pipewire pipewire-pulse wireplumber 2>/dev/null && \
    echo "  ✓ PipeWire enabled" || echo "  ⚠ PipeWire already running or failed"

# ── 6. Shell prompt ───────────────────────────────────────────
echo ""
echo "▶ Checking shell setup..."

if ! grep -q 'starship init' "$HOME/.zshrc" 2>/dev/null; then
    echo "" >> "$HOME/.zshrc"
    echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
    echo "  ✓ Starship added to .zshrc"
else
    echo "  ✓ Starship already in .zshrc"
fi

# ── Done ──────────────────────────────────────────────────────
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✓ Install complete!"
echo ""
echo "  Notes:"
echo "  • Log out and back into Hyprland to apply everything"
echo "  • If using SDDM, copy your wallpaper:"
echo "    sudo cp ~/.config/Ghibli.png /usr/share/sddm/themes/matugen-minimal/wallpaper.jpg"
echo "  • EasyEffects will autostart via .config/autostart"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
