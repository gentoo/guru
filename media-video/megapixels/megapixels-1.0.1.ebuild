# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson xdg

DESCRIPTION="A GTK3 camera application that knows how to deal with the media request api"
HOMEPAGE="https://git.sr.ht/~martijnbraam/megapixels"
SRC_URI="https://git.sr.ht/~martijnbraam/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	gui-libs/gtk
	media-gfx/imagemagick
	media-gfx/zbar
	media-libs/libraw
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/fix-preview-color.patch )

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
