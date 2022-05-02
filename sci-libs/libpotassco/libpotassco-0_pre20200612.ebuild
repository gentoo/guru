# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="2f2b80feac1e35cbe1cae986c44dbb20d4151c74"

DESCRIPTION="A utility library used by various potassco projects"
HOMEPAGE="https://github.com/potassco/libpotassco"
SRC_URI="https://github.com/potassco/${PN}/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test tools"

RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DLIB_POTASSCO_BUILD_TESTS=$(usex test)
		-DLIB_POTASSCO_BUILD_APP=$(usex tools)
		-DLIB_POTASSCO_INSTALL_LIB=ON
		-DLIB_POTASSCO_INSTALL_VERSIONED=OFF
	)
	cmake_src_configure
}
