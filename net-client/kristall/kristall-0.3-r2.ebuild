# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit out-of-source qmake-utils xdg

DESCRIPTION="Visual cross-platform gemini browser"
HOMEPAGE="https://github.com/MasterQ32/kristall"
if [ "${PV}" == "9999" ]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/MasterQ32/kristall.git"
else
	SRC_URI="https://github.com/MasterQ32/${PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	PATCHES=( "${FILESDIR}/${PN}-0.3_add_flags.patch" )
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-libs/openssl:=
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtnetwork:5[ssl]
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
"
DEPEND="${RDEPEND}"

my_src_compile() {
	eqmake5 "${S}"/src/kristall.pro
	emake
}

src_install() {
	cp "${BUILD_DIR}"/kristall . || die
	emake -o kristall DESTDIR="${D}" INSTALL="install -D" PREFIX="${EPREFIX}/usr" install
	einstalldocs
}
