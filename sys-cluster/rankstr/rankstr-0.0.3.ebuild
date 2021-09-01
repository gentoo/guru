# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake

DESCRIPTION="Split an MPI communicator into subcomms based on string values"
HOMEPAGE="https://github.com/ECP-VeloC/rankstr"
SRC_URI="https://github.com/ECP-VeloC/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="virtual/mpi"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${PN}-no-static.patch" )
RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DENABLE_TESTS=$(usex test)
		-DRANKSTR_LINK_STATIC=OFF
	)
	cmake_src_configure
}
