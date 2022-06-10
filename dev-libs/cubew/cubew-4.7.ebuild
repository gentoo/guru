# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="High performance C Writer library"
HOMEPAGE="https://www.scalasca.org/scalasca/software/cube-4.x"
SRC_URI="https://apps.fz-juelich.de/scalasca/releases/cube/${PV}/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="advanced-memory memory-tracking memory-tracing +zlib"

RDEPEND="
	sys-libs/binutils-libs
	zlib? ( sys-libs/zlib )
"
DEPEND="${RDEPEND}"

REQUIRED_USE="
	memory-tracking? ( advanced-memory )
	memory-tracing? ( advanced-memory )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-platform-mic
		$(use_with advanced-memory)
		$(use_with memory-tracking)
		$(use_with memory-tracing)
		$(use_with zlib compression)
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	mv "${ED}/usr/share/doc/cubew" "${ED}/usr/share/doc/${PF}" || die
	dodoc OPEN_ISSUES README
	docompress -x "${ED}/usr/share/doc/${PF}/example"
	find "${ED}" -name '*.la' -delete || die
	find "${ED}" -name '*.a' -delete || die
}
