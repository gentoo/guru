# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library for angharad programs"
HOMEPAGE="https://github.com/babelouest/orcania/"
SRC_URI="https://github.com/babelouest/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
RESTRICT="test"

BDEPEND="
	doc? (
		app-text/doxygen
		media-gfx/graphviz
	)
	virtual/pkgconfig
"
DEPEND="
"
RDEPEND="
	${DEPEND}
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_BASE64URL=OFF
		-DBUILD_ORCANIA_DOCUMENTATION=$(usex doc)
	)

	# bug 887885
	sed -i -e "s/-Werror//g" CMakeLists.txt || die

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use doc && cmake_build doc
}

src_install() {
	use doc && local HTML_DOCS=( doc/html/* )
	cmake_src_install
}
