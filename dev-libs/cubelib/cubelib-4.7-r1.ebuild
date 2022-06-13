# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools toolchain-funcs

DESCRIPTION="General purpose C++ library and tools"
HOMEPAGE="https://www.scalasca.org/scalasca/software/cube-4.x"
SRC_URI="https://apps.fz-juelich.de/scalasca/releases/cube/${PV}/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="R"

RDEPEND="
	sys-libs/zlib
	R? (
		dev-lang/R
		dev-R/Rcpp
		dev-R/RInside
	)
"
DEPEND="
	${RDEPEND}
	dev-cpp/gtest
"
BDEPEND="
	sys-devel/flex
	virtual/yacc
"

src_prepare() {
	rm -r vendor/googletest || die
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-platform-mic
		$(use_with R cube_dump_r)
	)
	econf CC="$(tc-getCC)" CXX="$(tc-getCXX)" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" "${myconf[@]}"
}

src_install() {
	default
	mv "${ED}/usr/share/doc/cubelib/example" "${ED}/usr/share/doc/${PF}/" || die
	rm -r "${ED}/usr/share/doc/cubelib" || die
	dodoc OPEN_ISSUES README
	docompress -x "/usr/share/doc/${PF}/example"
	find "${ED}" -name '*.a' -delete || die
	find "${ED}" -name '*.la' -delete || die
}
