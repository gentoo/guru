# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg-utils

DESCRIPTION="Screen sharing with multiplayer control, with voice"
HOMEPAGE="https://pop.com/home"
SRC_URI="https://download.pop.com/desktop-app/linux/${PV}/${PN}_${PV}_amd64.deb"

S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT=0
KEYWORDS="~amd64"
RESTRICT="strip"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/libxshmfence
	x11-libs/pango
"

QA_PREBUILT="*"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	# Because here is only one file: "copyright", no docs
	rm -rf usr/share/doc/ || die

	doins -r usr
	fperms +x /usr/bin/"${PN}"
}

pkg_postinst() {
	xdg_desktop_database_update

	einfo "If you want to share your screen - some compositor is required, like compton :("
}
