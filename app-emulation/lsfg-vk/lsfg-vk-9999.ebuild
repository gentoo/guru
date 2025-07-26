# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
inherit cargo cmake desktop flag-o-matic toolchain-funcs

DESCRIPTION="Lossless Scaling Frame Generation on Linux via DXVK/Vulkan"
HOMEPAGE="https://github.com/PancakeTAS/lsfg-vk"
LICENSE="MIT"
SLOT="0"
IUSE="+gui"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PancakeTAS/lsfg-vk"
	EGIT_SUBMODULES=(
		thirdparty/dxbc
		thirdparty/pe-parse
		thirdparty/volk
	)
else
	HASH_DXBC="80e316fd13d7e8938d99a08f1f405a0679c3ccfa"
	HASH_VOLK="be3dbd49bf77052665e96b6c7484af855e7e5f67"
	PEPARSE_VERSION="2.1.1"
	SRC_URI="
		https://github.com/PancakeTAS/lsfg-vk/archive/refs/tags/v${PV}.tar.gz
		https://github.com/PancakeTAS/dxbc/archive/${HASH_DXBC}.tar.gz
		https://github.com/trailofbits/pe-parse/archive/refs/tags/v${PEPARSE_VERSION}.tar.gz
		https://github.com/zeux/volk/archive/${HASH_VOLK}.tar.gz
	"
fi

BDEPEND="
	dev-util/spirv-headers
	dev-util/vulkan-headers
	gui? ( ${RUST_DEPEND} )
"
DEPEND="
	dev-cpp/toml11
	dev-util/glslang
	gui? (
		dev-libs/glib:2
		gui-libs/gtk:4[introspection]
		gui-libs/libadwaita
	)
	|| (
		media-libs/glfw
		media-libs/libsdl2
		media-libs/libsdl3
	)
	media-libs/vulkan-loader
"
RDEPEND="${DEPEND}"

src_unpack() {
	if [[ ${PV} != 9999 ]]; then
		use gui || default
	else
		git-r3_src_unpack
	fi

	if use gui; then
		if [[ ${PV} != 9999 ]]; then
			cargo_src_unpack
		else
			oldS="${S}"
			S="${S}/ui"
			cargo_live_src_unpack
			S="${oldS}"
		fi
	fi
}

src_prepare() {
	if [[ ${PV} != 9999 ]]; then
		mv ../dxbc-${HASH_DXBC} thirdparty/dxbc || die
		mv ../pe-parse-${PEPARSE_VERSION} thirdparty/pe-parse || die
		mv ../volk-${HASH_VOLK} thirdparty/volk || die
	fi

	# Static linking pe-parse
	sed -i\
		's/^option(BUILD_SHARED_LIBS "Build Shared Libraries" ON)$/option(BUILD_SHARED_LIBS "Build Shared Libraries" OFF)/'\
		thirdparty/pe-parse/CMakeLists.txt || die

	sed -i\
		's|add_library(${PROJECT_NAME} ${PEPARSERLIB_SOURCEFILES})|add_library(${PROJECT_NAME} STATIC ${PEPARSERLIB_SOURCEFILES})|'\
		thirdparty/pe-parse/pe-parser-library/CMakeLists.txt || die

	# Using system toml11
	sed -i\
		-e '/add_subdirectory(thirdparty\/toml11 EXCLUDE_FROM_ALL)/d' \
		-e '/get_target_property(TOML11_INCLUDE_DIRS toml11 INTERFACE_INCLUDE_DIRECTORIES)/{
N
/target_include_directories(lsfg-vk SYSTEM PRIVATE ${TOML11_INCLUDE_DIRS})/c\
find_package(toml11 REQUIRED)
}'\
		-e '/target_link_libraries(lsfg-vk PRIVATE/{:a;N;/)/!ba;s/\btoml11\b/toml11::toml11/g;s/\bSPIRV-Headers\b *//g}'\
		CMakeLists.txt || die

	# Using system spirv headers
	sed -i \
		-e '/add_subdirectory(spirv)/d' \
		-e '/target_link_libraries(dxbc/,/SPIRV-Headers)/d' \
		-e '/target_include_directories(dxbc SYSTEM/,/include\/dxvk)/c\
target_include_directories(dxbc\
	SYSTEM PUBLIC include/dxbc\
	SYSTEM PUBLIC include/spirv include/util include/dxvk\
)' \
		thirdparty/dxbc/CMakeLists.txt || die

	eapply_user
	cmake_src_prepare
}

src_configure() {
	tc-is-gcc && filter-lto # LTO with gcc causes segfaults at runtime
	cmake_src_configure
	use gui && { pushd ui > /dev/null || die; cargo_src_configure; }
}

src_compile() {
	cmake_src_compile
	use gui && { pushd ui > /dev/null || die; cargo_src_compile; }
}

src_install() {
	insinto "/usr/share/vulkan/implicit_layer.d/"
	doins "${S}/VkLayer_LS_frame_generation.json"
	dolib.so "${WORKDIR}/${P}_build/liblsfg-vk.so"
	if use gui; then
		dobin "${S}/ui/$(cargo_target_dir)/lsfg-vk-ui"
		domenu "${S}/ui/rsc/gay.pancake.lsfg-vk-ui.desktop"
		newicon -s 256 "${S}/ui/rsc/icon.png" "gay.pancake.lsfg-vk-ui.png"
	fi
}
