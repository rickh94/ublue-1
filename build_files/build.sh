#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging
# dnf5 -y copr enable ryanabx/cosmic-epoch
# 
dnf5 -y copr enable ryanabx/cosmic-epoch
dnf5 install -y cosmic-desktop 
dnf5 install -y rustup cockpit cockpit-machines helix gcc llvm chezmoi rclone
dnf5 -y copr enable avengemedia/dms
dnf5 install -y niri dms mako waybar swaybg swayidle dms-greeter fuzzel alacritty
dnf5 -y copr enable scottames/ghostty
dnf5 install -y ghostty
dnf5 -y copr enable wezfurlong/wezterm-nightly
dnf5 install -y wezterm


#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl disable gdm
systemctl disable sddm
systemctl enable cosmic-greeter

# flatpak install com.vivaldi.Vivaldi
