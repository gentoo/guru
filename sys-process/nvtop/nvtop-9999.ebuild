# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="NVIDIA GPUs htop like monitoring tool"
HOMEPAGE="https://github.com/Syllo/nvtop"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/Syllo/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/Syllo/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="unicode debug"

RDEPEND="
	sys-libs/ncurses:0=[unicode?]
	x11-drivers/nvidia-drivers
"

DEPEND="${RDEPEND}"

BDEPEND="
	virtual/pkgconfig
"

BUILD_DIR="${WORKDIR}/build"

CMAKE_CONF="
	!debug? ( -DCMAKE_BUILD_TYPE=Release )
	debug? ( -DCMAKE_BUILD_TYPE=Debug )
	unicode? ( -DCURSES_NEED_WIDE=TRUE )
"

PATCHES=(
	"${FILESDIR}"/${PN}-1.0.0-add-nvml.patch
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DNVML_INCLUDE_DIRS="${S}/include"
		${CMAKE_CONF}
	)

	cmake-utils_src_configure
}
