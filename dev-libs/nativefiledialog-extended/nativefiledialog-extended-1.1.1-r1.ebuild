# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="File dialog library with C and C++ bindings, based on nativefiledialog"
HOMEPAGE="https://github.com/btzy/nativefiledialog-extended"
SRC_URI="https://github.com/btzy/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="x11-libs/gtk+:3"
DEPEND="${RDEPEND}"
IUSE="test"

RESTRICT="!test? ( test )"
#PATCHES=( "${FILESDIR}/${P}-no-static.patch" )

src_prepare() {
	eapply_user
	sed -e "s|DESTINATION lib|DESTINATION $(get_libdir)|g" -i src/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DNFD_BUILD_TESTS=$(usex test)
	)
	cmake_src_configure
}
