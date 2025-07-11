# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Easy to integrate Vulkan memory allocation library"
HOMEPAGE="https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator"
SRC_URI="https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

BDEPEND="
	doc? ( app-text/doxygen )
"

src_configure() {
	local mycmakeargs=(
		-DVMA_BUILD_DOCUMENTATION=$(usex doc)
	)

	cmake_src_configure
}
