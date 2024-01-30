# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="OpenGL 2.1/1.5 to GL ES 2.0/1.1 translation library"
HOMEPAGE="https://ptitseb.github.io/gl4es/"
EGIT_REPO_URI="https://github.com/ptitSeb/gl4es.git"
LICENSE="MIT"
SLOT="0"
IUSE="X test"
RESTRICT="!test? ( test )"

DEPEND="
	media-libs/mesa[X?,egl(+)]
"
RDEPEND="${DEPEND}"
BDEPEND="test? ( dev-debug/apitrace )"

# Note: Should be added into virtual/opengl if moved to ::gentoo

src_configure() {
	local mycmakeargs=(
		-DNOX11=$(usex !X)
	)

	cmake_src_configure
}

pkg_install() {
	einfo "To use this replacement library add ${PREFIX}/usr/lib/gl4es/ to LD_LIBRARY_PATH"
}
