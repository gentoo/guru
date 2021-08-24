# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Identify and manipulate duplicate files"
HOMEPAGE="https://www.jodybruchon.com/software/#jdupes"
SRC_URI="https://github.com/jbruchon/jdupes/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=(
	"${FILESDIR}/${P}-test.sh.patch"
)

BDEPEND="virtual/pkgconfig"

src_prepare(){
	default
	chmod +x test.sh || die
}

src_configure() {
	sed -in 's/local//' Makefile || die
}

src_compile() {
	emake
}
