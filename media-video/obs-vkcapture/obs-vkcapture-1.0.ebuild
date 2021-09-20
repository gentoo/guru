# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_REMOVE_MODULES_LIST=( FindFreetype )

inherit xdg cmake

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nowrep/obs-vkcapture"
else
	SRC_URI="https://github.com/nowrep/obs-vkcapture/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="OBS Linux Vulkan/OpenGL game capture"
HOMEPAGE="https://github.com/nowrep/obs-vkcapture"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

BDEPEND="
	dev-util/vulkan-headers
	media-libs/shaderc
	media-libs/vulkan-loader
	>=media-video/obs-studio-27
"
RDEPEND="
	media-libs/libglvnd
	>=media-video/obs-studio-27
	x11-libs/libxcb:=
"

src_unpack() {
	default

	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
	fi
}

src_configure() {
	cmake_src_configure
}
