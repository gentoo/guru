# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib toolchain-funcs

COMMIT="ba331411f17702e01f6c2d7016eefebaa695871f"
DESCRIPTION="Simple library to speed up or slow down speech"
HOMEPAGE="https://github.com/waywardgeek/sonic"
SRC_URI="https://github.com/waywardgeek/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="sci-libs/fftw"
DEPEND="${RDEPEND}"

DOCS=( README doc/index.md )

src_prepare() {
	default
	sed "s|/lib|/$(get_libdir)|" -i Makefile || die
	sed "/install libsonic.a/d" -i Makefile || die
	sed "s/CC=gcc/CC=$(tc-getCC)/" -i Makefile || die
	export AR="$(tc-getAR)"
}

src_install() {
	default
	doman sonic.1
}
