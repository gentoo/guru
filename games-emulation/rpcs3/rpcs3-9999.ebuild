# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic git-r3 xdg

DESCRIPTION="PS3 emulator/debugger"
HOMEPAGE="https://rpcs3.net/"
EGIT_REPO_URI="https://github.com/RPCS3/rpcs3"
EGIT_SUBMODULES=( 'asmjit' 'llvm' '3rdparty/flatbuffers' '3rdparty/wolfssl'
	'3rdparty/SoundTouch/soundtouch' )
# Delete sources when ensuring yaml-cpp compiled with fexceptions
EGIT_SUBMODULES+=( '3rdparty/yaml-cpp' )

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

DEPEND="alsa? ( media-libs/alsa-lib )
	faudio? ( app-emulation/faudio )
	pulseaudio? ( media-sound/pulseaudio )
	app-arch/p7zip
	dev-libs/hidapi
	dev-libs/libevdev
	dev-libs/pugixml
	dev-libs/xxhash
	media-libs/cubeb
	media-libs/glew
	media-libs/libpng
	media-libs/openal
	sys-libs/zlib"
#	dev-cpp/yaml-cpp
RDEPEND="${DEPEND}"
BDEPEND=""

IUSE="alsa discord faudio +llvm pulseaudio vulkan wayland"

src_unpack() {
	git clone https://github.com/intel/ittapi "${WORKDIR}"/ittapi
	git-r3_src_unpack
}

src_prepare() {
	append-cflags -DNDEBUG -Wno-error=stringop-truncation
	append-cppflags -DNDEBUG -Wno-error=stringop-truncation

	# Disable cache
	sed -i -e '/find_program(CCACHE_FOUND/d' -e '/set(.*_FLAGS/d' \
		CMakeLists.txt || die

	# Unbundle hidapi
	sed -i -e '/hidapi\.h/{s:":<hidapi/:;s/"/>/}' rpcs3/Input/hid_pad_handler.h || die
	sed -i -e '/hidapi/d' 3rdparty/CMakeLists.txt
	sed -i -e '1afind_package(PkgConfig REQUIRED)\npkg_check_modules(hidapi-hidraw REQUIRED hidapi-hidraw)' rpcs3/CMakeLists.txt
	sed -i -e 's/3rdparty::hidapi/hidapi-hidraw/' rpcs3/CMakeLists.txt rpcs3/rpcs3qt/CMakeLists.txt || die
	sed -i -e 's/hid_write_control/hid_write/' rpcs3/Input/dualsense_pad_handler.cpp rpcs3/Input/ds4_pad_handler.cpp || die

	# Move ittapi to the right place via cmake
	local regex='/GIT_EXECUTABLE} clone/s!(.*!(COMMAND mv '
	regex+="${WORKDIR}"
	regex+='/ittapi \${ITTAPI_SOURCE_DIR}!'
	sed -i -e "${regex}" \
		llvm/lib/ExecutionEngine/IntelJITEvents/CMakeLists.txt || die ${regex}

	# Unbundle cubeb
	sed -i -e '/cubeb/d' 3rdparty/CMakeLists.txt || die
	sed -i -e '$afind_package(cubeb)\n' CMakeLists.txt || die
	sed -i -e 's/3rdparty::cubeb/cubeb/' rpcs3/Emu/CMakeLists.txt || die

	# Unbundle yaml-cpp: system yaml-cpp should be compiled with -fexceptions
	# sed -i -e '/yaml-cpp/d' 3rdparty/CMakeLists.txt || die
	# sed -i -e '$afind_package(yaml-cpp)\n' CMakeLists.txt || die
	# sed -i -e 's/3rdparty::yaml-cpp/yaml-cpp/' rpcs3/Emu/CMakeLists.txt \
	#	rpcs3/rpcs3qt/CMakeLists.txt || die

	# Unbundle glslang SPIRV
	sed -i -e '/add_subdirectory(glslang/d' \
		-e '/add_subdirectory(SPIRV/d' \
		-e '/if(VULKAN_FOUND)/afind_library(SPIRV libSPIRV.so)\nfind_library(SPIRV-Tools-opt libSPIRV-Tools-opt.so)\n' \
		-e '/target_link_libraries.*SPIRV/{s/SPIRV-Tools-opt/${&}/;s/SPIRV /${SPIRV} /}' \
		3rdparty/CMakeLists.txt || die
	sed -i -e '/#include "SPIRV/{s:":<glslang/:;s/"/>/}' rpcs3/Emu/RSX/VK/VKCommonDecompiler.cpp || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_LLVM_SUBMODULE=ON # ennoying really
		-DBUILD_SHARED_LIBS=OFF # to remove after unbundling
		-DUSE_DISCORD_RPC=$(usex discord)
		-DUSE_FAUDIO=$(usex faudio)
		-DUSE_PRECOMPILED_HEADERS=ON
		-DUSE_SYSTEM_CURL=ON
		-DUSE_SYSTEM_LIBPNG=ON
		-DUSE_SYSTEM_LIBUSB=ON
		-DUSE_SYSTEM_PUGIXML=ON
		-DUSE_SYSTEM_XXHASH=ON
		-DUSE_SYSTEM_ZLIB=ON
		-DUSE_VULKAN=$(usex vulkan)
		-DWITH_LLVM=$(usex llvm)
	)
	use faudio && mycmakeargs+=( -DUSE_SYSTEM_FAUDIO=$(usex faudio) )
	CMAKE_BUILD_TYPE=RELEASE cmake_src_configure
	sed -i -e 's/FFMPEG_LIB_AVFORMAT-NOTFOUND/avformat/' -e 's/FFMPEG_LIB_AVCODEC-NOTFOUND/avcodec/' \
		-e 's/FFMPEG_LIB_AVUTIL-NOTFOUND/avutil/' -e 's/FFMPEG_LIB_SWSCALE-NOTFOUND/swscale/' \
		-e 's/FFMPEG_LIB_SWRESAMPLE-NOTFOUND/swresample/' "${BUILD_DIR}"/build.ninja || die
}
