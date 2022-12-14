# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake edo

DESCRIPTION="PLASMA parallel library for dense linear algebra"
HOMEPAGE="
	https://bitbucket.org/icl/plasma
	https://github.com/NLAFET/plasma
"
SRC_URI="https://bitbucket.org/icl/plasma/downloads/${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="BSD-2"
SLOT="0"
# TODO: magma (requires cuda)

RDEPEND="
	dev-lang/lua
	virtual/blas
	virtual/cblas
	virtual/lapack
	virtual/lapacke
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( README.md ChangeLog )

src_prepare() {
#	edo rm -r tools/lua*
	edo sed -e "s|DESTINATION lib|DESTINATION $(get_libdir)|g" -i CMakeLists.txt
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DPLASMA_DETECT_LUA=ON
		-DPLASMA_DETECT_MAGMA=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	einstalldocs
}
