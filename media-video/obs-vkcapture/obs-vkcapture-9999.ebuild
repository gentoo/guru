# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_REMOVE_MODULES_LIST=( FindFreetype )

inherit xdg cmake-multilib

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

BDEPEND="
	dev-util/vulkan-headers
	media-libs/shaderc
	media-libs/vulkan-loader[${MULTILIB_USEDEP}]
	>=media-video/obs-studio-27[wayland]
	x11-libs/libdrm[${MULTILIB_USEDEP}]
"
RDEPEND="
	media-libs/libglvnd[${MULTILIB_USEDEP}]
	>=media-video/obs-studio-27[wayland]
	x11-libs/libdrm[${MULTILIB_USEDEP}]
	x11-libs/libxcb:=[${MULTILIB_USEDEP}]
"

QA_SONAME="
	/usr/lib64/libVkLayer_obs_vkcapture.so
	/usr/lib64/libobs_glcapture.so
	/usr/lib/libVkLayer_obs_vkcapture.so
	/usr/lib/libobs_glcapture.so
"

src_unpack() {
	default

	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
	fi
}

multilib_src_configure() {
if ! multilib_is_native_abi; then
	local mycmakeargs+=(
	-DBUILD_PLUGIN=OFF
	)
fi
	cmake_src_configure
}
