#!/bin/bash

REPO_DIR="$HOME/cachyos-dotfiles"

echo "Memulai proses restore konfigurasi CachyOS..."

# 1. Menginstal paket sistem (Arch/CachyOS)
echo "Menginstal Fish, Zoxide, Eza, Bat, Ripgrep, Starship, Waydroid, dan MPV..."
sudo pacman -Syu --needed rsync fish starship zoxide eza bat ripgrep waydroid mpv

# Catatan: Emulator (RPCS3, PCSX2, Eden) tidak di-restore otomatis via pacman karena menggunakan AUR.
# Anda bisa menginstalnya secara manual menggunakan yay atau paru (contoh: paru -S rpcs3-bin pcsx2).

# 2. Mengembalikan file konfigurasi
echo "Menerapkan konfigurasi ke sistem..."
rsync -a "$REPO_DIR/.config/" ~/.config/
rsync -a "$REPO_DIR/.local/share/applications/" ~/.local/share/applications/
rsync -a "$REPO_DIR/scripts/" ~/scripts/

# 3. Mengatur Fish sebagai shell default
if [[ "$SHELL" != *"/fish" ]]; then
    echo "Mengubah shell default ke Fish..."
    chsh -s $(which fish)
fi

echo "Restore selesai!"
echo "Silakan log out dan log in kembali agar konfigurasi KDE Plasma dan Fish Shell diterapkan sepenuhnya."

