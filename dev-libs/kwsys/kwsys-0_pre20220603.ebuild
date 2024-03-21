# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="c28e27bc4ad8e12d88b05f30eec19b2987c60721"

DESCRIPTION="Kitware System Library"
HOMEPAGE="https://gitlab.kitware.com/utils/kwsys"
SRC_URI="https://gitlab.kitware.com/utils/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.bz2"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="test"


RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DKWSYS_INSTALL_BIN_DIR=bin
		-DKWSYS_INSTALL_INCLUDE_DIR=include
		-DKWSYS_INSTALL_LIB_DIR=$(get_libdir)
		-DKWSYS_STANDALONE=ON

		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}
