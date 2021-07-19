# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="libbsctools"
HOMEPAGE="https://github.com/bsc-performance-tools/libbsctools"
SRC_URI="https://github.com/bsc-performance-tools/libbsctools/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/boost:="
DEPEND="${RDEPEND}"

src_prepare() {
	default
	./bootstrap || die
}

src_install() {
	MAKEOPTS="-j1" emake DESTDIR="${D}" install
	dodoc NEWS README AUTHORS
		mv "${ED}/usr/share/example" "${ED}/usr/share/doc/${PF}/examples" || die
		docompress -x "/usr/share/doc/${PF}/examples"
	find "${D}" -name '*.la' -delete || die
	find "${D}" -name '*.a' -delete || die
}
