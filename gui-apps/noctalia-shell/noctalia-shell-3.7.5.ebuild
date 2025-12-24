# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Noctalia Configuration for Quickshell"
HOMEPAGE="https://github.com/noctalia-dev/noctalia-shell"
SRC_URI="https://github.com/noctalia-dev/noctalia-shell/releases/download/v${PV}/noctalia-v${PV}.tar.gz"

S="${WORKDIR}/noctalia-release"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cliphist cava wlsunset xdg-desktop-portal evolution-data-server polkit-kde-agent matugen xwayland"

RDEPEND="
gui-apps/quickshell
media-video/gpu-screen-recorder
app-misc/brightnessctl
"

# Optional dependencies
RDEPEND="${RDEPEND}
cliphist? ( app-misc/cliphist )
cava? ( media-sound/cava )
wlsunset? ( gui-apps/wlsunset )
xdg-desktop-portal? ( sys-apps/xdg-desktop-portal )
evolution-data-server? ( gnome-extra/evolution-data-server )
polkit-kde-agent? ( kde-plasma/polkit-kde-agent )
matugen? ( x11-misc/matugen )
xwayland? ( gui-apps/xwayland-satellite )
"

src_unpack() {
default_src_unpack
}

src_install() {
# Create the configuration directory
dodir "/etc/xdg/quickshell/noctalia-shell"

# Install the configuration files
cp -r "${S}"/* "${ED}/etc/xdg/quickshell/noctalia-shell/" || die
}

# Metadata for installation
pkg_postinst() {
elog "Noctalia Quickshell configuration has been installed to /etc/xdg/quickshell/noctalia-shell."
elog "Note: uninstalling this package will not remove this configuration, so if you intend to keep using Quickshell you may want to remove it manually."
}
