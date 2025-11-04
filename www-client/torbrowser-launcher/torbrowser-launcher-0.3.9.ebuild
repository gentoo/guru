# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 xdg

DESCRIPTION="A program to help you securely download and run Tor Browser"
HOMEPAGE="https://gitlab.torproject.org/tpo/applications/torbrowser-launcher"
SRC_URI="https://gitlab.torproject.org/tpo/applications/torbrowser-launcher/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="wayland"

# Copied from `www-client/firefox-bin::gentoo`'s `RDEPEND`
BROWSER_RDEPEND="
	|| (
		media-libs/libpulse
		media-sound/apulse
	)
	>=app-accessibility/at-spi2-core-2.46.0:2
	>=dev-libs/glib-2.26:2
	media-libs/alsa-lib
	media-libs/fontconfig
	>=media-libs/freetype-2.4.10
	sys-apps/dbus
	virtual/freedesktop-icon-theme
	>=x11-libs/cairo-1.10[X]
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.11:3[X,wayland?]
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libxcb
	>=x11-libs/pango-1.22.0
"
RDEPEND="
	dev-python/gpgmepy[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyside:6[core,gui,widgets,${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]

	app-crypt/gnupg
	net-vpn/tor

	${BROWSER_RDEPEND}
"
DEPEND="
	dev-python/distro[${PYTHON_USEDEP}]
"
BDEPEND="
	sys-devel/gettext
"

distutils_enable_tests import-check

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
