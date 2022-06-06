# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="EVpath is an event transport middleware layer"
HOMEPAGE="https://github.com/GTkorvo/evpath"
SRC_URI="https://github.com/GTKorvo/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="enet infiniband libfabric test udt4" # nvml nnti

RDEPEND="
	dev-libs/atl
	dev-libs/dill
	dev-libs/ffs

	enet? ( net-libs/enet )
	infiniband? ( sys-block/libfabric )
	libfabric? ( sys-block/libfabric )
	udt4? ( net-libs/udt:4 )
"
DEPEND="${RDEPEND}"

RESTRICT="!test? ( test )"
PATCHES=( "${FILESDIR}/${P}-find-udt.patch" )

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DEVPATH_INSTALL_HEADERS=ON
		-DEVPATH_INSTALL_PKGCONFIG=ON
		-DEVPATH_QUIET=OFF
		-DEVPATH_USE_NNTI=OFF
		-DEVPATH_USE_NVML=OFF

		-DBUILD_TESTING=$(usex test)
		-DEVPATH_USE_ENET=$(usex enet)
		-DEVPATH_USE_IBVERBS=$(usex infiniband)
		-DEVPATH_USE_LIBFABRIC=$(usex libfabric)
		-DEVPATH_USE_UDT4=$(usex udt4)
	)
#		-DEVPATH_USE_ZPL_ENET=$(usex enet)
	cmake_src_configure
}

src_install() {
	cmake_src_install
}
