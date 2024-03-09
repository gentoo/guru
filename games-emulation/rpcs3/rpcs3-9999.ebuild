# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic git-r3 xdg

DESCRIPTION="PS3 emulator/debugger"
HOMEPAGE="https://rpcs3.net/"
EGIT_REPO_URI="https://github.com/RPCS3/rpcs3"
EGIT_SUBMODULES=( 'asmjit' '3rdparty/glslang' '3rdparty/miniupnp/miniupnp' '3rdparty/rtmidi/rtmidi' '3rdparty/wolfssl'
	'3rdparty/SoundTouch/soundtouch' )
# Delete sources when ensuring yaml-cpp compiled with fexceptions
EGIT_SUBMODULES+=( '3rdparty/yaml-cpp' )

LICENSE="GPL-2"
SLOT="0"
IUSE="discord faudio +llvm vulkan wayland"

DEPEND="
	app-arch/p7zip
	dev-libs/flatbuffers
	dev-libs/hidapi
	dev-libs/libevdev
	dev-libs/pugixml
	dev-libs/xxhash
	dev-qt/qtbase:6[concurrent,dbus,gui,widgets]
	dev-qt/qtmultimedia:6
	dev-qt/qtsvg:6
	media-libs/cubeb
	media-libs/glew
	media-libs/libglvnd
	media-libs/libpng:=
	media-libs/openal
	media-video/ffmpeg:=
	net-misc/curl
	sys-devel/llvm:=
	sys-libs/zlib
	virtual/libusb:1
	faudio? ( app-emulation/faudio )
	vulkan? ( media-libs/vulkan-loader[wayland?] )
	wayland? ( dev-libs/wayland )
"
RDEPEND="${DEPEND}"

QA_PREBUILT="usr/share/rpcs3/test/.*"
QA_WX_LOAD="usr/share/rpcs3/test/*"

src_prepare() {
	# Disable automagic ccache
	sed -i -e '/find_program(CCACHE_FOUND ccache)/d' CMakeLists.txt || die

	# Unbundle hidapi
	sed -i -e '/hidapi\.h/{s:":<hidapi/:;s/"/>/}' rpcs3/Input/hid_pad_handler.h || die
	sed -i -e '/hidapi/d' 3rdparty/CMakeLists.txt || die
	sed -i -e '1afind_package(PkgConfig REQUIRED)\npkg_check_modules(hidapi-hidraw REQUIRED hidapi-hidraw)' \
		rpcs3/CMakeLists.txt || die
	sed -i -e 's/3rdparty::hidapi/hidapi-hidraw/' rpcs3/CMakeLists.txt rpcs3/rpcs3qt/CMakeLists.txt || die
	sed -i -e 's/hid_write_control/hid_write/' \
		rpcs3/Input/dualsense_pad_handler.cpp rpcs3/Input/ds4_pad_handler.cpp || die

	# Unbundle cubeb
	sed -i -e '/cubeb/d' 3rdparty/CMakeLists.txt || die
	sed -i -e '$afind_package(cubeb)\n' CMakeLists.txt || die
	sed -i -e 's/3rdparty::cubeb/cubeb/' rpcs3/Emu/CMakeLists.txt || die

	# Unbundle yaml-cpp: system yaml-cpp should be compiled with -fexceptions
	# sed -i -e '/yaml-cpp/d' 3rdparty/CMakeLists.txt || die
	# sed -i -e '$afind_package(yaml-cpp)\n' CMakeLists.txt || die
	# sed -i -e 's/3rdparty::yaml-cpp/yaml-cpp/' rpcs3/Emu/CMakeLists.txt \
	#	rpcs3/rpcs3qt/CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	filter-lto

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF # to remove after unbundling
		-DUSE_PRECOMPILED_HEADERS=ON
		-DUSE_SYSTEM_CURL=ON
		-DUSE_SYSTEM_FFMPEG=ON
		-DUSE_SYSTEM_FLATBUFFERS=ON
		-DUSE_SYSTEM_LIBPNG=ON
		-DUSE_SYSTEM_LIBUSB=ON
		-DUSE_SYSTEM_PUGIXML=ON
		-DUSE_SYSTEM_XXHASH=ON
		-DUSE_SYSTEM_ZLIB=ON
		-DUSE_DISCORD_RPC=$(usex discord)
		-DUSE_FAUDIO=$(usex faudio)
		-DUSE_VULKAN=$(usex vulkan)
		-DWITH_LLVM=$(usex llvm)
	)
	# These options are defined conditionally to suppress QA notice
	use faudio && mycmakeargs+=( -DUSE_SYSTEM_FAUDIO=$(usex faudio) )
	use vulkan && mycmakeargs+=( $(cmake_use_find_package wayland Wayland) )

	cmake_src_configure

	sed -i -e 's/FFMPEG_LIB_AVFORMAT-NOTFOUND/avformat/' -e 's/FFMPEG_LIB_AVCODEC-NOTFOUND/avcodec/' \
		-e 's/FFMPEG_LIB_AVUTIL-NOTFOUND/avutil/' -e 's/FFMPEG_LIB_SWSCALE-NOTFOUND/swscale/' \
		-e 's/FFMPEG_LIB_SWRESAMPLE-NOTFOUND/swresample/' "${BUILD_DIR}"/build.ninja || die
}
