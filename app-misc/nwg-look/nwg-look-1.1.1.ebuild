# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop go-module xdg

DESCRIPTION="GTK settings editor adapted to work on wlroots-based compositors"
HOMEPAGE="https://github.com/nwg-piotr/nwg-look"
SRC_URI="
	https://github.com/nwg-piotr/nwg-look/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/emanuelquintana-glitch/guru/releases/download/nwg-look-deps-1.1.1/${P}-deps.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-accessibility/at-spi2-core
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
BDEPEND=">=dev-lang/go-1.25.0"

DOCS=( README.md )

src_unpack() {
	default
}

src_prepare() {
	default
	cp "${WORKDIR}/go.mod" . || die
	cp "${WORKDIR}/go.sum" . || die
	cp -r "${WORKDIR}/vendor" . || die
}

src_compile() {
	ego build -mod=vendor -o bin/nwg-look .
}

src_install() {
	insinto /usr/share/nwg-look
	doins stuff/main.glade
	doins -r langs
	doicon -s scalable stuff/nwg-look.svg
	domenu stuff/nwg-look.desktop
	dobin bin/nwg-look
	einstalldocs
}
