# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="NVIDIA GPUs htop like monitoring tool"
HOMEPAGE="https://github.com/Syllo/nvtop"

if [[ "${PV}" == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/Syllo/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/Syllo/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="unicode"

RDEPEND="
	sys-libs/ncurses:0=
	x11-drivers/nvidia-drivers
"

DEPEND="${RDEPEND}"

BDEPEND="
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${PN}-1.0.0-add-nvml.patch
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DNVML_INCLUDE_DIRS="${S}/include"
		-DCURSES_NEED_WIDE=$(usex unicode)
	)

	cmake_src_configure
}
