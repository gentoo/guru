# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools qmake-utils

DESCRIPTION="A library for automated hinting of truetype fonts"
HOMEPAGE="https://www.freetype.org/ttfautohint/index.html"
SRC_URI="https://download.savannah.gnu.org/releases/freetype/${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="|| ( FTL GPL-2+ )"
SLOT="0"
IUSE="doc qt5"

RDEPEND="
	media-libs/harfbuzz
	media-libs/freetype
	qt5? ( dev-qt/qtgui:5 )
"
DEPEND="${RDEPEND}"
BDEPEND="sys-apps/help2man"

src_prepare() {
	default
	#set version
	sed -e "s|m4_esyscmd.*VERSION])|${PV//_/-}|" -i configure.ac || die

	eautoreconf
}

src_configure() {
	local _q="$(qt5_get_bindir)"
	local myeconfargs=(
		--disable-static
		$(use_with doc)
		$(use_with qt5 qt)
	)

	QMAKE="${_q}/qmake" MOC="${_q}/moc" UIC="${_q}/uic" RCC="${_q}/rcc" econf "${myeconfargs[@]}"
}

src_compile() {
	default
	emake "${PN}.1" $(usex qt5 "${PN}GUI.1" '') -C frontend
}

src_install() {
	default
	doman frontend/*.1
	find "${ED}" -name '*.la' -delete || die
	find "${ED}" -name '*.a' -delete || die
}
