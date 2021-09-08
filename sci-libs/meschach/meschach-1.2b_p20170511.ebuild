# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake

COMMIT="201bcf933bcd4d971c3ab50e0651c6e65ba004b9"
MAJOR="$(ver_cut 1)"
VERSION="$(ver_cut 1-2)"

DESCRIPTION="Meschach is a C-language library of routines for performing matrix computations"
HOMEPAGE="
	https://github.com/yageek/Meschach
	http://homepage.divms.uiowa.edu/~dstewart/meschach
"
S="${WORKDIR}/${PN^}-${COMMIT}"

SRC_URI="https://github.com/yageek/Meschach/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
LICENSE="meschach"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+complex +double munroll old segmem +float +sparse unroll"

#PATCHES=(
#	"${FILESDIR}/.patch"
#)

src_configure() {
	mycmakeargs=(
		-DANDROID_COMPILE=OFF
		-DCOMPLEX_OPTION=$(usex complex)
		-DREAL_DBL_OPTION=$(usex double)
		-DREAL_FLT_OPTION=$(usex float)
		-DMUNROLL_OPTION=$(usex munroll)
		-DSEGMENTED_OPTION=$(usex segmem)
		-DSPARSE_OPTION=$(usex sparse)
		-DVUNROLL_OPTION=$(usex unroll)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_install() {
	pushd "${BUILD_DIR}" || die
	ln -s "lib${PN}.so" "lib${PN}.so.${MAJOR}" || die
	ln -s "lib${PN}.so.${MAJOR}" "lib${PN}.so.${VERSION}" || die
	dolib.so "lib${PN}.so"
	dolib.so "lib${PN}.so.${MAJOR}"
	dolib.so "lib${PN}.so.${VERSION}"

#	exeinto "/usr/libexec/${PN}"
#	doexe iotort
#	doexe itertort
#	doexe memtort
#	doexe mfuntort
#	doexe sptort
#	doexe torture
#	doexe ztorture
	popd || die

	insinto "/usr/include/${PN}"
	doins *.h

	insinto "/usr/share/${PN}"
	doins *.dat

	dodoc -r DOC/.
	dodoc README.md
}
