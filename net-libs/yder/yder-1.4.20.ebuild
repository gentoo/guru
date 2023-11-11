# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Logging library for C applications"
HOMEPAGE="https://github.com/babelouest/yder/"
SRC_URI="https://github.com/babelouest/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc systemd"
RESTRICT="test"

BDEPEND="
	doc? (
		app-doc/doxygen
		media-gfx/graphviz
	)
	net-libs/orcania
	systemd? (
		sys-apps/systemd
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
		-DBUILD_YDER_DOCUMENTATION=$(usex doc)
		-DWITH_JOURNALD=$(usex systemd)
	)

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
