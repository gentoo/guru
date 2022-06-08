# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="General purpose C++ library and tools"
HOMEPAGE="https://www.scalasca.org/scalasca/software/cube-4.x"
SRC_URI="https://apps.fz-juelich.de/scalasca/releases/cube/${PV}/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-cpp/gtest"

src_prepare() {
	rm -r vendor/googletest || die
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-platform-mic
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	mv "${ED}/usr/share/doc/cubelib/example" "${ED}/usr/share/doc/${PF}/" || die
	rm -r "${ED}/usr/share/doc/cubelib" || die
	dodoc OPEN_ISSUES README
	docompress -x "${ED}/usr/share/doc/${PF}/example"
	find "${ED}" -name '*.a' -delete || die
}
