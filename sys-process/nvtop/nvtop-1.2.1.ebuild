# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

NVIDIA_PV="455.38"

DESCRIPTION="NVIDIA GPUs htop like monitoring tool"
HOMEPAGE="https://github.com/Syllo/nvtop"

if [[ "${PV}" == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/Syllo/${PN}.git"
	inherit git-r3
	SRC_URI="
		https://download.nvidia.com/XFree86/nvidia-settings/nvidia-settings-${NVIDIA_PV}.tar.bz2
	"
else
	SRC_URI="
		https://github.com/Syllo/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
		https://download.nvidia.com/XFree86/nvidia-settings/nvidia-settings-${NVIDIA_PV}.tar.bz2
	"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="debug unicode"

RDEPEND="
	sys-libs/ncurses:0=[unicode?]
	x11-drivers/nvidia-drivers
"

DEPEND="${RDEPEND}"

BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local CMAKE_CONF="
		!debug? ( -DCMAKE_BUILD_TYPE=Release )
		debug? ( -DCMAKE_BUILD_TYPE=Debug )
		unicode? ( -DCURSES_NEED_WIDE=TRUE )
	"
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DNVML_INCLUDE_DIRS="${S}/include"
		${CMAKE_CONF}
	)

	cp "${WORKDIR}/nvidia-settings-${NVIDIA_PV}/src/nvml.h" "${S}/include/nvml.h" || die

	cmake_src_configure
}
