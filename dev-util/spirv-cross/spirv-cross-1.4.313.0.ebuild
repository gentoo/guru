# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib

DESCRIPTION="Tool for performing reflection on SPIR-V."
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-Cross"
SRC_URI="https://github.com/KhronosGroup/SPIRV-Cross/archive/vulkan-sdk-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/SPIRV-Cross-vulkan-sdk-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

multilib_src_configure() {
	local mycmakeargs=(
		-DSPIRV_CROSS_SHARED=ON
	)
	cmake_src_configure
}
