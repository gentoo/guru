# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GTK settings editor adapted to work on wlroots-based compositors"
HOMEPAGE="https://github.com/nwg-piotr/nwg-look"
SRC_URI="
	https://github.com/nwg-piotr/nwg-look/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://slackware.lngn.net/pub/source/nwg-look/${PN}-vendor-${PV}.tar.xz
"

inherit desktop go-module xdg

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/glib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	x11-apps/xcur2png
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/pango
"
RDEPEND="${DEPEND}"

DOCS=( README.md )

src_unpack() {
	default
	mv -v vendor "${S}" || die
}

src_compile() {
	ego build
}

src_install() {
	insinto /usr/share/nwg-look
	doins stuff/main.glade
	doins -r langs

	insinto /usr/share/pixmaps
	doins stuff/nwg-look.svg

	domenu stuff/nwg-look.desktop

	dobin nwg-look

	einstalldocs
}
