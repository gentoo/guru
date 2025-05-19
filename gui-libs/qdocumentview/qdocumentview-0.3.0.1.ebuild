# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Widget to render multi-page documents"
HOMEPAGE="https://gitlab.com/extraqt/qdocumentview"
SRC_URI="https://gitlab.com/extraqt/qdocumentview/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cups djvu postscript"

DEPEND="
	app-text/poppler[qt6]
	dev-qt/qtbase:6[gui,widgets]
	cups? ( net-print/cups )
	djvu? ( app-text/djvu )
	postscript? ( app-text/libspectre )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-fix-automagic.patch"
)

src_configure() {
	local emesonargs=(
		$(meson_feature cups)
		$(meson_feature djvu)
		$(meson_feature postscript)
	)
	meson_src_configure
}
