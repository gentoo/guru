# Copyright 2023 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Library to handle RPG Maker 2000/2003 and EasyRPG projects"
HOMEPAGE="https://github.com/EasyRPG/liblcf"
SRC_URI="https://github.com/EasyRPG/liblcf/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc"

RDEPEND="
	dev-libs/expat
	dev-libs/icu:=
	doc? ( app-text/doxygen )
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=True
		-DLIBLCF_UPDATE_MIMEDB=False
	)

	cmake_src_configure
}

src_test() {
	cmake_build check
}
