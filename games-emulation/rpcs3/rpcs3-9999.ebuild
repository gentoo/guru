# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic xdg optfeature

ASMJIT_COMMIT="416f7356967c1f66784dc1580fe157f9406d8bff" # remotes/origin/a32_port~71
GLSLANG_COMMIT="fc9889c889561c5882e83819dcaffef5ed45529b" # tags/15.3.0
WOLFSSL_COMMIT="b077c81eb635392e694ccedbab8b644297ec0285" # tags/5.8.0-stable
SOUNDTOUCH_COMMIT="3982730833b6daefe77dcfb32b5c282851640c17" # master
YAMLCPP_COMMIT="456c68f452da09d8ca84b375faa2b1397713eaba" # master
FUSION_COMMIT="008e03eac0ac1d5f85e16f5fcaefdda3fee75cb8" # tags/1.2.11
VULKANMEMORYALLOCATOR_COMMIT="1d8f600fd424278486eade7ed3e877c99f0846b1" # tags/3.3.0
GAMEMODE_COMMIT="c54d6d4243b0dd0afcb49f2c9836d432da171a2b" # tags/1.8.2

DESCRIPTION="PS3 emulator/debugger"
HOMEPAGE="https://rpcs3.net/"
if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/RPCS3/rpcs3"
	EGIT_SUBMODULES=(
	'asmjit' '3rdparty/glslang' '3rdparty/wolfssl'
	'3rdparty/SoundTouch/soundtouch' '3rdparty/fusion/fusion' '3rdparty/GPUOpen/VulkanMemoryAllocator'
	'3rdparty/feralinteractive/feralinteractive' '3rdparty/yaml-cpp'
	)
	inherit git-r3
else
	SRC_URI="
		https://github.com/RPCS3/rpcs3/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/asmjit/asmjit/archive/${ASMJIT_COMMIT}.tar.gz -> ${PN}-asmjit-${ASMJIT_COMMIT}.tar.gz
		https://github.com/KhronosGroup/glslang/archive/${GLSLANG_COMMIT}.tar.gz -> ${PN}-glslang-${GLSLANG_COMMIT}.tar.gz
		https://github.com/wolfSSL/wolfssl/archive/${WOLFSSL_COMMIT}.tar.gz -> ${PN}-wolfssl-${WOLFSSL_COMMIT}.tar.gz
		https://github.com/RPCS3/soundtouch/archive/${SOUNDTOUCH_COMMIT}.tar.gz
			-> ${PN}-soundtouch-${SOUNDTOUCH_COMMIT}.tar.gz
		https://github.com/RPCS3/yaml-cpp/archive/${YAMLCPP_COMMIT}.tar.gz -> ${PN}-yaml-cpp-${SOUNDTOUCH_COMMIT}-.tar.gz
		https://github.com/xioTechnologies/Fusion/archive/${FUSION_COMMIT}.tar.gz -> ${PN}-fusion-${FUSION_COMMIT}.tar.gz
		https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator/archive/${VULKANMEMORYALLOCATOR_COMMIT}.tar.gz
			-> ${PN}-VulkanMemoryAllocator-${VULKANMEMORYALLOCATOR_COMMIT}.tar.gz
		https://github.com/FeralInteractive/gamemode/archive/${GAMEMODE_COMMIT}.tar.gz -> ${PN}-GameMode.tar.gz
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="discord faudio +llvm opencv vulkan wayland"

DEPEND="
	app-arch/7zip
	app-arch/zstd
	>=dev-libs/protobuf-33.0.0
	dev-libs/hidapi
	dev-libs/libevdev
	dev-libs/pugixml
	dev-libs/stb
	dev-qt/qtbase:6[concurrent,dbus,gui,widgets]
	dev-qt/qtmultimedia:6
	dev-qt/qtsvg:6
	media-libs/alsa-lib
	media-libs/cubeb
	media-libs/glew
	media-libs/libglvnd
	media-libs/libpng:=
	media-libs/openal
	media-libs/rtmidi
	media-video/ffmpeg:=
	net-libs/miniupnpc:=
	net-misc/curl
	llvm-core/llvm:=
	virtual/zlib:=
	virtual/libusb:1
	x11-libs/libX11
	faudio? ( app-emulation/faudio )
	opencv? ( media-libs/opencv )
	vulkan? ( media-libs/vulkan-loader[wayland?] )
	wayland? ( dev-libs/wayland )
"
RDEPEND="${DEPEND}"

QA_PREBUILT="usr/share/rpcs3/test/.*"
QA_WX_LOAD="usr/share/rpcs3/test/*"

PATCHES=(
	"${FILESDIR}/${P}-system-stb.patch"
)

src_prepare() {
	if [[ ${PV} != "9999" ]]; then
		rmdir "${S}/3rdparty/asmjit/asmjit" || die
		mv "${WORKDIR}/asmjit-${ASMJIT_COMMIT}" "${S}/3rdparty/asmjit/asmjit" || die

		rmdir "${S}/3rdparty/glslang/glslang" || die
		mv "${WORKDIR}/glslang-${GLSLANG_COMMIT}" "${S}/3rdparty/glslang/glslang" || die

		rmdir "${S}/3rdparty/wolfssl/wolfssl" || die
		mv "${WORKDIR}/wolfssl-${WOLFSSL_COMMIT}" "${S}/3rdparty/wolfssl/wolfssl" || die

		rmdir "${S}/3rdparty/SoundTouch/soundtouch" || die
		mv "${WORKDIR}/soundtouch-${SOUNDTOUCH_COMMIT}" "${S}/3rdparty/SoundTouch/soundtouch" || die

		rmdir "${S}/3rdparty/yaml-cpp/yaml-cpp" || die
		mv "${WORKDIR}/yaml-cpp-${YAMLCPP_COMMIT}" "${S}/3rdparty/yaml-cpp/yaml-cpp" || die

		rmdir "${S}/3rdparty/fusion/fusion" || die
		mv "${WORKDIR}/Fusion-${FUSION_COMMIT}" "${S}/3rdparty/fusion/fusion" || die

		rmdir "${S}/3rdparty/GPUOpen/VulkanMemoryAllocator" || die
		mv "${WORKDIR}/VulkanMemoryAllocator-${VULKANMEMORYALLOCATOR_COMMIT}" \
			"${S}/3rdparty/GPUOpen/VulkanMemoryAllocator" || die

		rmdir "${S}/3rdparty/feralinteractive/feralinteractive" || die
		mv "${WORKDIR}/gamemode-${GAMEMODE_COMMIT}" \
			"${S}/3rdparty/feralinteractive/feralinteractive" || die

		#Define RPCS3 Version
		{ echo "#define RPCS3_GIT_VERSION \"${PV}\""
		echo '#define RPCS3_GIT_BRANCH "master"'
		echo '#define RPCS3_GIT_FULL_BRANCH "RPCS3/rpcs3/master"'
		echo '#define RPCS3_GIT_VERSION_NO_UPDATE 1'; } > rpcs3/git-version.h
	fi

	# Disable automagic ccache
	sed -i -e '/find_program(CCACHE_PATH ccache .*)/d' CMakeLists.txt || die

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
		-DUSE_SYSTEM_CUBEB=ON
		-DUSE_SYSTEM_CURL=ON
		-DUSE_SYSTEM_FFMPEG=ON
		-DUSE_SYSTEM_PROTOBUF=ON
		-DUSE_SYSTEM_HIDAPI=ON
		-DUSE_SYSTEM_LIBPNG=ON
		-DUSE_SYSTEM_LIBUSB=ON
		-DUSE_SYSTEM_MINIUPNPC=ON
		-DUSE_SYSTEM_PUGIXML=ON
		-DUSE_SYSTEM_RTMIDI=ON
		-DUSE_SYSTEM_ZLIB=ON
		-DUSE_SYSTEM_ZSTD=ON
		-DUSE_DISCORD_RPC=$(usex discord)
		-DUSE_FAUDIO=$(usex faudio)
		-DUSE_SYSTEM_OPENCV=$(usex opencv)
		-DUSE_VULKAN=$(usex vulkan)
		-DWITH_LLVM=$(usex llvm)
		$(cmake_use_find_package wayland Wayland)
	)
	# These options are defined conditionally to suppress QA notice
	use faudio && mycmakeargs+=( -DUSE_SYSTEM_FAUDIO=$(usex faudio) )

	cmake_src_configure

	sed -i -e 's/FFMPEG_LIB_AVFORMAT-NOTFOUND/avformat/' -e 's/FFMPEG_LIB_AVCODEC-NOTFOUND/avcodec/' \
		-e 's/FFMPEG_LIB_AVUTIL-NOTFOUND/avutil/' -e 's/FFMPEG_LIB_SWSCALE-NOTFOUND/swscale/' \
		-e 's/FFMPEG_LIB_SWRESAMPLE-NOTFOUND/swresample/' "${BUILD_DIR}"/build.ninja || die
}

src_install() {
	cmake_src_install

	# remove unneccessary files to save some space
	rm -rf "${ED}/usr/share/rpcs3/"{git,test} || die
}

pkg_postinst() {
	optfeature "FeralInteractive GameMode support" games-util/gamemode
}
