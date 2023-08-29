# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Library to handle RPG Maker 2000/2003 and EasyRPG projects"
HOMEPAGE="https://github.com/EasyRPG/liblcf"
SRC_URI="https://github.com/EasyRPG/liblcf/archive/refs/tags/${PV}.tar.gz
	-> ${P}.gh.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc tools"

RDEPEND="
	dev-libs/expat
	dev-libs/icu:=
"
DEPEND="${RDEPEND}"
BDEPEND="doc? ( app-doc/doxygen[dot] )"

HTML_DOCS="doc/*"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=True
		-DLIBLCF_UPDATE_MIMEDB=False
		-DLIBLCF_ENABLE_TOOLS=$(usex tools)
		$(cmake_use_find_package doc Doxygen)
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	# Why do we have to build this explicitly :/
	use doc && cmake_build liblcf_doc
}

src_test() {
	cmake_build check
}
