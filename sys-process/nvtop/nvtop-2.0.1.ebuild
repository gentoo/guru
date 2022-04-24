# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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

IUSE="unicode video_cards_amdgpu video_cards_nvidia"

RDEPEND="
	video_cards_amdgpu? ( x11-libs/libdrm[video_cards_amdgpu] )
	video_cards_nvidia? ( x11-drivers/nvidia-drivers )
	sys-libs/ncurses:0=
"

DEPEND="${RDEPEND}"

BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DNVML_INCLUDE_DIRS="${S}/include"
		-DCURSES_NEED_WIDE=$(usex unicode)
		-DNVIDIA_SUPPORT=$(usex video_cards_nvidia)
		-DAMDGPU_SUPPORT=$(usex video_cards_amdgpu)
	)

	cp "${WORKDIR}/nvidia-settings-${NVIDIA_PV}/src/nvml.h" "${S}/include/nvml.h" || die

	cmake_src_configure
}
