# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GTK3 settings editor adapted to work in the sway / wlroots environment"
HOMEPAGE="https://github.com/nwg-piotr/nwg-look"
SRC_URI="https://github.com/nwg-piotr/nwg-look/archive/refs/tags/v${PV}.tar.gz -> nwg-look-${PV}.tar.gz
				https://github.com/micielski/nwg-look-vendor/releases/download/${PV}/nwg-look-${PV}-vendor.tar.xz
"

inherit go-module xdg-utils desktop

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
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

src_compile() {
	ego build
}

src_install() {
	dobin nwg-look
	insinto /usr/share/nwg-look
	doins -r langs
	doins stuff/main.glade
	insinto /usr/share/pixmaps
	doins stuff/nwg-look.svg
	domenu stuff/nwg-look.desktop
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
