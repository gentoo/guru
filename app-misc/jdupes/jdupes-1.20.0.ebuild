# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#inherit toolchain-funcs

DESCRIPTION="Identify and manipulate duplicate files"
HOMEPAGE="https://www.jodybruchon.com/software/#jdupes"
SRC_URI="https://github.com/jbruchon/jdupes/archive/refs/tags/v1.20.0.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
#DOCS=( CHANGES CONTRIBUTORS README )
src_configure() {
#	econf
	sed -in 's/local//' Makefile
}
src_compile() {
	emake
}
