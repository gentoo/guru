# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="SCIM IMEngine module using Canna"
HOMEPAGE="https://osdn.net/projects/scim-imengine"
SRC_URI="https://free.nchc.org.tw/osdn//scim-imengine/29155/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND="
	app-i18n/canna
	app-i18n/scim
	dev-libs/atk
	dev-libs/glib:2
	dev-libs/libltdl
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz:=
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/pango
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${P}-fix_ftbfs_gtk3.patch" )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myargs=(
		--disable-static
		--enable-shared
		$(use_enable debug)
	)
	econf "${myargs[@]}"
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
