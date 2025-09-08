# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
COMMIT="a03191777152b932b9bf15f45d439bf38e8c7679"

inherit cmake desktop

DESCRIPTION="Qt version of the ZDL ZDoom launcher"
HOMEPAGE="https://zdl.vectec.net/wiki/Main_Page"
SRC_URI="https://github.com/qbasicer/qzdl/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/inih
	dev-qt/qtbase:6[widgets]
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-qt/qtbase:6
"

PATCHES=(
	"${FILESDIR}"/${PN}-cmake.patch
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
	)

	cmake_src_configure
}

src_install() {
	dobin "${BUILD_DIR}/zdl"

	doicon -s scalable res/zdl3.svg

	make_desktop_entry zdl "ZDL" zdl3 "Game;ActionGame"
}
