# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="C/C++ library to mainly provide Semantic Versioned implementation"
HOMEPAGE="https://github.com/azaeldevel/octetos-core"
SRC_URI="https://github.com/azaeldevel/octetos-core/archive/1.2.2-br.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/cunit
	>=sys-devel/gcc-8.1
	>=sys-devel/bison-3.1
	dev-libs/libconfig
"

src_unpack() {
	default
	ln -s octetos-core-1.2.2-br "${P}"
}

src_configure() {
	eautoreconf -fi
}

src_compile() {
	if [ -f Makefile ] || [ -f GNUmakefile ] || [ -f makefile ]; then
		emake || die "emake failed"
	fi
}
