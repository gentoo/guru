# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=(lua5-4)

inherit cmake flag-o-matic git-r3 lua-single xdg

DESCRIPTION="Sega Dreamcast, Naomi and Atomiswave emulator"
HOMEPAGE="https://github.com/flyinghead/flycast"
EGIT_REPO_URI="https://github.com/flyinghead/flycast"
EGIT_SUBMODULES=( 'core/deps/asio' 'core/deps/breakpad' 'core/deps/libjuice' 'core/deps/libusb-cmake'
	'core/deps/luabridge' 'core/deps/DreamPicoPort-API' 'core/deps/rcheevos' 'core/deps/volk'
	'core/deps/xbyak' 'core/deps/VulkanMemoryAllocator' 'core/deps/tinygettext'
	'core/deps/DreamPicoPort-API/ext/libusb-cmake' 'core/deps/tinygettext/external/tinycmmc' )

LICENSE="GPL-2"
SLOT="0"

IUSE="alsa ao lua opengl +openmp pulseaudio vulkan"

DEPEND="
	dev-cpp/asio
	dev-cpp/websocketpp
	dev-libs/libchdr
	dev-libs/libzip
	dev-libs/xxhash
	media-libs/libsdl2
	net-libs/miniupnpc
	virtual/zlib:=
	alsa? ( media-libs/alsa-lib )
	ao? ( media-libs/libao )
	lua? ( ${LUA_DEPS} )
	opengl? ( virtual/opengl )
	openmp? ( sys-devel/gcc:*[openmp] )
	pulseaudio? ( media-libs/libpulse )
	vulkan? (
		dev-util/glslang:=
		dev-util/spirv-headers
	)
"
RDEPEND="${DEPEND}"

REQUIRED_USE="|| ( opengl vulkan ) || ( ao alsa pulseaudio )"

src_unpack() {
	use lua && EGIT_SUBMODULES+=( 'core/deps/luabridge' )
	git-r3_src_unpack
}
src_prepare() {
	# Ensure unneeded deps are not bundled
	for dep in chdr dirent glslang libretro-common libzip miniupnpc oboe patches SDL vixl xxHash; do
		rm -rf core/deps/${dep}
	done

	# Skip alsa if flag not enabled
	use !alsa && sed -i -e '/find_package(ALSA)/d' CMakeLists.txt

	# Skip ao if flag not enabled
	use !ao && sed -i -e '/pkg_check_modules(AO/d' CMakeLists.txt

	if use lua; then # Lua 5.2 not available in gentoo anymore
		sed -i -e '/find_package(Lua/s/5.2/5.4/' CMakeLists.txt
	else # Skip lua if flag not enabled
		sed -i -e '/find_package(Lua/d' CMakeLists.txt
	fi

	# Skip pulseaudio if flag not enabled
	use !pulseaudio && sed -i -e '/pkg_check_modules(LIBPULSE/d' CMakeLists.txt

	# Unbundle xxHash
	sed -i -e '/XXHASH_BUILD_XXHSUM/{N;N;s/.*/target_link_libraries(${PROJECT_NAME} PRIVATE xxhash)/}' \
		CMakeLists.txt || die

	# Do not use ccache
	sed -i -e '/find_program(CCACHE_PROGRAM/d' CMakeLists.txt

	# Vulkan-header
	sed -i -e '/add_subdirectory(core.*Vulkan-Headers)$/,/Vulkan::Headers/d' \
		-e '/core\/deps\/Vulkan-Headers\/include)/d' CMakeLists.txt
	sed -i -e '/ResourceLimits.h/a#include <glslang/Public/ShaderLang.h>' \
		core/rend/vulkan/compiler.cpp
	if use vulkan; then
		sed -i -e '$atarget_link_libraries(${PROJECT_NAME} PRIVATE glslang glslang-default-resource-limits)' CMakeLists.txt
		sed -i -e 's/throwResultException/detail::throwResultException/' core/rend/vulkan/vmallocator.{h,cpp}
		grep -rl 'vk::resultCheck' | xargs sed -i -e 's/vk::resultCheck/vk::detail::resultCheck/g'
		grep -rl 'vk::DynamicLoader' | xargs sed -i -e 's/vk::DynamicLoader/vk::detail::DynamicLoader/g'
		sed -i -e '/end\/transform_matrix.h/a#include <set>' core/rend/vulkan/vulkan_context.cpp || die
	fi

	# Unbundle SDL under linux: (revert crazy commit: #4408aa7)
	sed -i -e '/USE_HOST_SDL_DEFAULT/s/OFF/ON/' CMakeLists.txt

	# Fix cmake version
	sed -i -e '/cmake_minimum_required/s/2.6.*$/3.20)/' core/deps/xbyak/CMakeLists.txt || die
	sed -i -e 's/3.2/3.20/' core/deps/glm/CMakeLists.txt || die

	append-cxxflags -Wno-unused-result

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DUSE_HOST_LIBCHDR=ON
		-DUSE_OPENGL=$(usex opengl)
		-DUSE_OPENMP=$(usex openmp)
		-DUSE_VULKAN=$(usex vulkan)
		-DUSE_HOST_LIBZIP=ON
		-DUSE_HOST_GLSLANG=ON
		-DUSE_HOST_SDL=ON
		-DWITH_SYSTEM_ZLIB=ON
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	rm -rf "${D}"/usr/$(get_libdir) "${D}"/usr/include
}
