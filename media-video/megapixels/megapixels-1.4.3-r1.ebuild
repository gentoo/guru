# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson xdg

DESCRIPTION="GTK4 camera application that knows how to deal with the media request api"
HOMEPAGE="https://git.sr.ht/~martijnbraam/megapixels"
SRC_URI="https://gitlab.com/postmarketOS/megapixels/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	dev-libs/glib:2
	gui-libs/gtk:4
	media-gfx/zbar
	media-libs/libepoxy
	media-libs/tiff:=
"
RDEPEND="
	${DEPEND}
	media-gfx/dcraw
	media-gfx/imagemagick
"

PATCHES=(
	# bug #945308
	"${FILESDIR}/${P}-gcc15.patch"
)

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
