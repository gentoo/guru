# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="8c6a9e30576f07bf470ad6f09458a2dcd7a6a84a"

DESCRIPTION="PNG encoder and decoder"
HOMEPAGE="
	http://lodev.org/lodepng
	https://github.com/lvandeve/lodepng
"
SRC_URI="https://github.com/lvandeve/lodepng/archive/${COMMIT}.tar.gz -> ${P}-${COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="benchmark pngdetail showpng test"

DEPEND="
	benchmark? ( media-libs/libsdl )
	showpng? ( media-libs/libsdl )
"
RDEPEND="${DEPEND}"

RESTRICT="!test? ( test )"
PATCHES=( "${FILESDIR}/${PN}-makefile.patch" )

src_compile() {
	emake liblodepng.so
	use test && emake unittest
	use benchmark && emake benchmark
	use showpng && emake showpng
	use pngdetail && emake pngdetail
}

src_install() {
	dodoc README.md
	doheader lodepng.h
	dolib.so liblodepng.so
	use showpng && dobin showpng
	use pngdetail && dobin pngdetail
	exeinto /usr/libexec/lodepng
	use benchmark && doexe benchmark
}

src_test() {
	./unittest || die
}
