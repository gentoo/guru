# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="d91742bcd18bf9dc9b5e94f48a4aa59d3c954fd2"

inherit cmake

DESCRIPTION="solver for pseudo-Boolean constraints"
HOMEPAGE="https://github.com/niklasso/minisatp/tree/master"
SRC_URI="https://github.com/niklasso/minisatp/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/gmp
	sci-mathematics/minisat
	sys-libs/zlib
"
DEPEND="${RDEPEND}"
BDEPEND="app-admin/chrpath"

PATCHES=(
	"${FILESDIR}/${PF}-find-gmp.patch"
	"${FILESDIR}/${PF}-fix-build-errors.patch"
)

src_configure() {
	local mycmakeargs=(
		-DSTATIC_BINARIES=OFF
	)
	cmake_src_configure
}

src_install() {
	dodoc README
	dodoc -r Examples
	newman doc/minisat+.1 minisatp.1
	dolib.so "${BUILD_DIR}/libminisatp.so"
	dolib.so "${BUILD_DIR}/libminisatp.so.1"
	dolib.so "${BUILD_DIR}/libminisatp.so.1.1.0"
	dobin "${BUILD_DIR}/minisatp"

	chrpath -d "${ED}/usr/bin/minisatp" || die
}
