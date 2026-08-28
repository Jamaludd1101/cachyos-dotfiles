#!/bin/bash

REPO_DIR="$HOME/cachyos-dotfiles"

echo "Memulai proses backup konfigurasi CachyOS..."

# Membuat struktur direktori repositori
mkdir -p "$REPO_DIR/.config"
mkdir -p "$REPO_DIR/.local/share/applications"
mkdir -p "$REPO_DIR/scripts"

# 1. Backup Konfigurasi Shell & Terminal (Fish, Starship)
echo "Mem-backup Fish dan Starship..."
rsync -a ~/.config/fish/ "$REPO_DIR/.config/fish/"
cp ~/.config/starship.toml "$REPO_DIR/.config/" 2>/dev/null

# 2. Backup Konfigurasi KDE Plasma (Wayland)
echo "Mem-backup setting KDE Plasma..."
cp ~/.config/kdeglobals "$REPO_DIR/.config/" 2>/dev/null
cp ~/.config/kglobalshortcutsrc "$REPO_DIR/.config/" 2>/dev/null
cp ~/.config/kwinrc "$REPO_DIR/.config/" 2>/dev/null
cp ~/.config/plasmashellrc "$REPO_DIR/.config/" 2>/dev/null
cp ~/.config/klaunchrc "$REPO_DIR/.config/" 2>/dev/null

# 3. Backup Shortcut Kustom (Waydroid)
echo "Mem-backup shortcut desktop Waydroid..."
rsync -a --include='*.desktop' --exclude='*' ~/.local/share/applications/ "$REPO_DIR/.local/share/applications/"

# 4. Backup Konfigurasi Emulator (Tanpa Save Data)
echo "Mem-backup konfigurasi RPCS3, PCSX2, dan Eden..."
# RPCS3: Mengecualikan folder savedata dan profil user (home)
if [ -d "$HOME/.config/rpcs3" ]; then
    rsync -a --exclude='dev_hdd0/savedata/' --exclude='dev_hdd0/home/' ~/.config/rpcs3/ "$REPO_DIR/.config/rpcs3/"
fi

# PCSX2: Mengecualikan memory card dan save states
if [ -d "$HOME/.config/PCSX2" ]; then
    rsync -a --exclude='memcards/' --exclude='sstates/' ~/.config/PCSX2/ "$REPO_DIR/.config/PCSX2/"
fi

# Eden Emulator
if [ -d "$HOME/.config/eden" ]; then
    rsync -a ~/.config/eden/ "$REPO_DIR/.config/eden/"
fi

# 5. Backup Aplikasi Tambahan (MPV) & Script Personal
echo "Mem-backup konfigurasi MPV dan folder script lokal..."
rsync -a ~/.config/mpv/ "$REPO_DIR/.config/mpv/" 2>/dev/null
rsync -a ~/scripts/ "$REPO_DIR/scripts/" 2>/dev/null

echo "Backup selesai! Periksa folder $REPO_DIR sebelum melakukan git push."
