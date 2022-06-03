# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION='iMatix GSL code generator'
HOMEPAGE="https://github.com/zeromq/gsl"
SRC_URI="https://github.com/zeromq/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE='GPL-3+'
SLOT="0"
IUSE="examples"

DEPEND="dev-libs/libpcre:3"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-respect-flags.patch" )

src_prepare() {
	tc-export AR RANLIB
	export CCNAME="$(tc-getCC)"
	export CCPLUS="$(tc-getCXX)"
	default
}

src_install() {
	DESTDIR="${D}/usr" emake install
	if use examples; then
		dodoc -r examples
		dodoc -r doc/examples
	fi
	dodoc doc/denormalizing*
	dodoc -r doc/modules
	dodoc README*
}
