#!/bin/sh

# A script to prepare a void installation as my machine
### Requires installing and configuring doas

# Configuring doas
if ! command -v doas >/dev/null 2>&1; then
	printf "### installing doas"
	sudo xbps-install -Sy opendoas
	sudo echo "permit nopass $(whoami) as root" > /etc/doas.conf
fi

alias xi="doas xbps-install -Sy"

# Update the system
printf "### updating the system\n"
doas xbps-install -u xbps; doas xbps-install -Su

# Base packages
printf "### installing base packages\n"
xi base-devel git curl wget libXft-devel libXinerama-devel libX11-devel libXrandr-devel pkg-config elogind dbus polkit neovim
doas ln -s /etc/sv/dbus /var/service
doas ln -s /etc/sv/elogind /var/service
doas ln -s /etc/sv/polkitd /var/service

# Xorg
# Wayland
# printf "### installing Xorg\n"
# xi xorg-minimal xinit xkill setxkbmap xrdb xdg-utils xdg-user-dirs xprop picom xsetroot
printf "### installing Wayland\n"
xi river kanshi sandbar mako grim slurp swayidle waylock wbg wl-clipboard wlr-randr poweralertd 
xi xdg-utils xdg-user-dirs xdg-desktop-portal xdg-desktop-portal-wlr

# Enable some repositories
printf "### enabling some repositories\n"
xi void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree

# Install nvidia
printf "### installing nvidia\n"
xi nvidia nvidia-dkms nvidia-opencl

# Multimedia
xi alsa-utils pipewire alsa-pipewire wireplumber sof-firmware alsa-ucm-conf mpd ncmpcpp mpv yt-dlp nsxiv ffmpeg zathura zathura-pdf-mupdf

# Configure pipewire
doas mkdir -p /etc/pipewire/pipewire.conf.d
doas ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
doas ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

# Essential packages
xi zsh zsh-autosuggestions zsh-completions zsh-history-substring-search
 
xi nix
doas ln -s /etc/var/nix-daemon /var/service

xi ufw
xi wine wine-gecko wine-mono winetricks mesa-dri-32bit lutris mesa-vulkan-intel
xi fontconfig dejavu-fonts-ttf amiri-font noto-fonts-emoji arc-theme awdaita-plus lxappearance
xi fzf ripgrep

xi vnstat
doas ln -s /etc/sv/vnstatd /var/service

xi libspa-bluetooth pulsemixer bluez bluez-alsa dhcpcd
xi NetworkManager
xi lm_sensors
xi firefox
xi dunst
xi xbacklight xbansih sxhkd
xi scrot
xi xclip
xi xdotool
xi neomutt msmtp offlineimap notmuch fuse-exfat ntfs-3g rsync ImageMagick pass
xi tmux tmate
xi syncthing
xi docker qemu virt-manager texlive-basic texlive-pictures go nodejs gcc
xi mlocate
xi delta

doas updatedb
doas reboot
