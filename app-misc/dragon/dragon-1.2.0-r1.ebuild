# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Simple drag-and-drop source/sink for X and Wayland"
HOMEPAGE="https://github.com/mwh/dragon"
SRC_URI="https://github.com/mwh/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-accessibility/at-spi2-core
	dev-libs/glib
	media-libs/harfbuzz
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/gdk-pixbuf
	x11-libs/pango
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	sed 's/\(`pkg-config --cflags .*`\) \(`pkg-config --libs .*`\)/\1 $(CFLAGS) \2 $(LDFLAGS)/' \
		-i Makefile || die
}

src_install() {
	dobin dragon
	dodoc README
	doman dragon.1
}
