# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Fast C OBJ parser"

HOMEPAGE="https://github.com/thisistherk/fast_obj"

SRC_URI="https://github.com/thisistherk/fast_obj/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"

SLOT="0"

KEYWORDS="~amd64"

IUSE="test"

RESTRICT="!test? ( test )"

PATCHES=( "${FILESDIR}/static-to-shared.patch" )

src_configure() {
	local mycmakeargs=(
		-DFAST_OBJ_BUILD_TEST=$(usex test)
	)

	cmake_src_configure
}

src_install() {
	dolib.a "${BUILD_DIR}/libfast_obj_lib.a"
}
