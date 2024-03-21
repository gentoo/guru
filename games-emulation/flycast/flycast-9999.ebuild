# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{3..4} )

inherit cmake git-r3 lua-single xdg

DESCRIPTION="Sega Dreamcast, Naomi and Atomiswave emulator"
HOMEPAGE="https://github.com/flyinghead/flycast"
EGIT_REPO_URI="https://github.com/flyinghead/flycast"
EGIT_SUBMODULES=( 'core/deps/breakpad' 'core/deps/volk' 'core/deps/VulkanMemoryAllocator' )

LICENSE="GPL-2"
SLOT="0"

IUSE="alsa ao lua opengl +openmp pulseaudio vulkan"

DEPEND="
	dev-libs/libchdr
	dev-libs/libzip
	dev-libs/xxhash
	media-libs/libsdl2
	net-libs/miniupnpc
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	ao? ( media-libs/libao )
	lua? ( ${LUA_DEPS} )
	opengl? ( virtual/opengl )
	openmp? ( sys-devel/gcc:*[openmp] )
	pulseaudio? ( media-libs/libpulse )
	vulkan? (
		>=dev-util/glslang-1.3.231
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

	# Skip lua if flag not enabled
	use !lua && sed -i -e '/find_package(Lua)/d' CMakeLists.txt

	# Skip pulseaudio if flag not enabled
	use !pulseaudio && sed -i -e '/pkg_check_modules(LIBPULSE/d' CMakeLists.txt

	# Unbundle glslang
	sed -i -e '/add_subdirectory(core\/deps\/glslang/{N;s/.*/find_library(GLSLANG libglslang.so)\nfind_library(SPIRV libSPIRV.so)\ntarget_link_libraries(${PROJECT_NAME} PRIVATE ${GLSLANG} ${SPIRV})/}' CMakeLists.txt || die
	sed -i -e '/include.*SPIRV/{s:":<glslang/:;s/"/>/}' core/rend/vulkan/shaders.h \
		core/rend/vulkan/compiler.cpp || die
	# Crazy commit fix: 8d0654c
	sed -i -e '/maxMeshViewCountNV/a256,256,128,128,128,128,128,128,4,' \
		core/rend/vulkan/compiler.cpp || die

	# Unbundle xxHash
	sed -i -e '/XXHASH_BUILD_XXHSUM/{N;N;s/.*/target_link_libraries(${PROJECT_NAME} PRIVATE xxhash)/}' \
		CMakeLists.txt || die

	# Unbundle chdr
	sed -i -e '/add_subdirectory.*chdr/d' -e 's/chdr-static/chdr/' \
		-e 's:core/deps/chdr/include:/usr/include/chdr:' CMakeLists.txt || die

	# Do not use ccache
	sed -i -e '/find_program(CCACHE_FOUND/d' CMakeLists.txt

	# Ensure static libs are not built
	sed -i -e '/BUILD_SHARED_LIBS/d' CMakeLists.txt

	# Vulkan-header
	sed -i -e '/add_subdirectory(core.*Vulkan-Headers)$/,/Vulkan::Headers/d' \
		-e '/core\/deps\/Vulkan-Headers\/include)/d' CMakeLists.txt
	sed -i -e 's:SPIRV/GlslangToSpv.h:glslang/&:' core/rend/vulkan/compiler.cpp
	if use vulkan; then
		sed -i -e '$atarget_link_libraries(${PROJECT_NAME} PRIVATE glslang-default-resource-limits)' CMakeLists.txt
	fi

	# Do not use ccache
	sed -i -e '/find_program(CCACHE_PROGRAM ccache)/d' CMakeLists.txt

	# Revert crazy commit: #4408aa7
	sed -i -e '/if(NOT APPLE AND (/s/.*/if( NOT APPLE )/' CMakeLists.txt

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_OPENGL=$(usex opengl)
		-DUSE_OPENMP=$(usex openmp)
		-DUSE_VULKAN=$(usex vulkan)
		-DUSE_HOST_LIBZIP=ON
		-DWITH_SYSTEM_ZLIB=ON
	)
	cmake_src_configure
}
