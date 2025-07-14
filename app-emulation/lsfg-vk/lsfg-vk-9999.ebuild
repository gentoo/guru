# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Lossless Scaling Frame Generation on Linux via DXVK/Vulkan"
HOMEPAGE="https://github.com/PancakeTAS/lsfg-vk"
LICENSE="MIT"
SLOT="0"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PancakeTAS/lsfg-vk"
	EGIT_SUBMODULES=(
		dxbc
		pe-parse
	)
else
	HASH_DXBC="04ca5e9ae5fef6c0c65ea72bbaa7375327f11454"
	PEPARSE_VERSION="2.1.1"
	SRC_URI="
		https://github.com/PancakeTAS/lsfg-vk/archive/refs/tags/v${PV}.tar.gz
		https://github.com/PancakeTAS/dxbc/archive/${HASH_DXBC}.tar.gz
		https://github.com/trailofbits/pe-parse/archive/refs/tags/v${PEPARSE_VERSION}.tar.gz
	"
fi

BDEPEND="
	dev-util/spirv-headers
	dev-util/vulkan-headers
"
DEPEND="
	media-libs/vulkan-loader
"
RDEPEND="${DEPEND}"

src_prepare() {
	if [[ ${PV} != 9999 ]]; then
		mv ../dxbc-${HASH_DXBC} dxbc || die
		mv ../pe-parse-${PEPARSE_VERSION} pe-parse || die
	fi

	sed -i 's/^option(BUILD_SHARED_LIBS "Build Shared Libraries" ON)$/option(BUILD_SHARED_LIBS "Build Shared Libraries" OFF)/' pe-parse/CMakeLists.txt || die
	sed -i 's|add_library(${PROJECT_NAME} ${PEPARSERLIB_SOURCEFILES})|add_library(${PROJECT_NAME} STATIC ${PEPARSERLIB_SOURCEFILES})|' pe-parse/pe-parser-library/CMakeLists.txt || die

	sed -i '/^set(CMAKE_C_COMPILER clang)$/d; /^set(CMAKE_CXX_COMPILER clang++)$/d' CMakeLists.txt dxbc/CMakeLists.txt || die
	sed -i 's|"library_path": "\.\./\.\./\.\./lib/liblsfg-vk\.so"|"library_path": "liblsfg-vk.so"|' VkLayer_LS_frame_generation.json || die

	eapply_user
	cmake_src_prepare
}

src_install() {
	insinto "/usr/share/vulkan/implicit_layer.d/"
	doins "${S}/VkLayer_LS_frame_generation.json"
	dolib.so "${WORKDIR}/${P}_build/liblsfg-vk.so"
}
