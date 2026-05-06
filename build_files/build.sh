#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging
 
dnf5 --enablerepo=terra install -y nwg-look noctalia-shell cliphist evolution-data-server
dnf5 install -y cockpit cockpit-machines helix gcc llvm chezmoi rclone adw-gtk3-theme qt6ct virt-manager android-tools podman-machine podman-tui libvirt qemu-kvm qemu edk2-ovmf guestfs-tools podman-compose

dnf5 -y copr enable ryanabx/cosmic-epoch
dnf5 -y copr enable yalter/niri
dnf5 -y copr enable scottames/ghostty

# dnf5 install -y cosmic-desktop 
dnf5 install -y cosmic-greeter
dnf5 install -y niri mako fuzzel
dnf5 install -y ghostty

dnf5 -y copr disable ryanabx/cosmic-epoch
dnf5 -y copr disable scottames/ghostty
dnf5 -y copr disable yalter/niri

wget -O /usr/share/polkit-1/actions/com.bitwarden.Bitwarden.policy https://raw.githubusercontent.com/bitwarden/clients/main/apps/desktop/resources/com.bitwarden.desktop.policy
chown root:root /usr/share/polkit-1/actions/com.bitwarden.Bitwarden.policy
#chcon system_u:object_r:usr_t:s0 /usr/share/polkit-1/actions/com.bitwarden.Bitwarden.policy

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl enable libvirtd
# systemctl disable gdm || true
# systemctl disable sddm || true
systemctl disable plasmalogin
# systemctl enable greetd
systemctl enable cosmic-greeter

# flatpak install com.vivaldi.Vivaldi
