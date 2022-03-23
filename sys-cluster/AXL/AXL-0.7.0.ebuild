# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="AXL provides a common C interface to transfer files in an HPC storage hierarchy"
HOMEPAGE="https://github.com/ECP-VeloC/AXL"
SRC_URI="https://github.com/ECP-VeloC/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test threads"

RDEPEND="
	sys-libs/zlib
	sys-cluster/KVTree
"
DEPEND="${RDEPEND}"

RESTRICT="!test? ( test )"
PATCHES=(
	"${FILESDIR}/${PN}-0.5.0-no-static.patch"
	"${FILESDIR}/no-install-readme.patch"
)

src_configure() {
	local mycmakeargs=(
		-DAXL_LINK_STATIC=OFF
		-DBUILD_SHARED_LIBS=ON
		-DENABLE_CRAY_DW=OFF
		-DENABLE_IBM_BBAPI=OFF
		-DENABLE_PTHREADS=$(usex threads)
		-DENABLE_TESTS=$(usex test)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dodoc -r doc/.
}
