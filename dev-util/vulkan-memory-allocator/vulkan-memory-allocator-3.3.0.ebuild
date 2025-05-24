# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Easy to integrate Vulkan memory allocation library."
HOMEPAGE="https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator"
SRC_URI="https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/VulkanMemoryAllocator-${PV}"

LICENSE="MIT-0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc samples"

src_prepare() {
	sed -i "s|/doc/VulkanMemoryAllocator|/doc/${PF}|g" CMakeLists.txt

	eapply_user
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_INCLUDEDIR=include/vulkan
		-DVMA_ENABLE_INSTALL=on
		-DVMA_BUILD_DOCUMENTATION=$(usex doc)
		-DVMA_BUILD_SAMPLES=$(usex samples)
	)
	cmake_src_configure
}
