# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg

DESCRIPTION="A Nintendo 3DS Emulator"
HOMEPAGE="https://citra-emu.org"
EGIT_REPO_URI="https://github.com/citra-emu/citra"
EGIT_SUBMODULES=(
	'catch2' 'dds-ktx' 'discord-rpc' 'dynarmic' 'library-headers' 'libyuv'
	'lodepng' 'nihstro' 'sirit' 'soundtouch' 'vma' 'xbyak'
)

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="cubeb nls openal +gui sdl +system-libfmt +telemetry"

RDEPEND="
	cubeb? ( media-libs/cubeb )
	media-video/ffmpeg:=[fdk]
	gui? ( nls? ( dev-qt/qttools:6[linguist] )
			dev-qt/qtbase:6[widgets,gui,opengl,network]
			dev-qt/qtmultimedia:6 )
	sdl? (
		media-libs/libsdl2
		>=dev-libs/inih-52
	)
	system-libfmt? ( >=dev-libs/libfmt-9:= )
	>=dev-libs/openssl-1.1:=
	app-arch/zstd
	dev-libs/boost:=
	dev-libs/crypto++:=
	dev-libs/teakra
	net-libs/enet:1.3=
	virtual/libusb:1
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-cpp/cpp-jwt
	dev-cpp/robin-map
	dev-util/spirv-headers
"
REQUIRED_USE="|| ( gui sdl )"

src_unpack() {
	if ! use system-libfmt; then
		EGIT_SUBMODULES+=( 'fmt' )
	fi
	if use openal; then
		EGIT_SUBMODULES+=( 'openal-soft' )
	fi
	git-r3_src_unpack

	cp -a "${S}"/externals/xbyak "${S}"/externals/dynarmic/externals/ || die

	# Do not fetch via sources because this file always changes
	curl https://api.citra-emu.org/gamedb/ > "${S}"/compatibility_list.json
}

src_prepare() {
	# Dynarmic: ensure those are unbundled
	for ext in fmt robin-map; do
		rm -rf externals/dynarmic/externals/${ext} || die
	done

	# Do not care about submodules wanted one are already fetched
	sed -i -e '/check_submodules_present()/d' CMakeLists.txt || die

	# Unbundle inih
	sed -i -e '/inih/d' externals/CMakeLists.txt || die
	sed -i -e '1ifind_package(PkgConfig REQUIRED)\npkg_check_modules(INIH REQUIRED INIReader)' \
		-e '/target_link_libraries/s/inih/${INIH_LIBRARIES}/' src/citra/CMakeLists.txt || die
	sed -i -e 's:inih/cpp/::' src/citra/config.cpp || die

	# Unbundle libfmt
	if use system-libfmt; then
		sed -i -e '/fmt/d' externals/CMakeLists.txt || die
		sed -i -e '/find_package(Threads/afind_package(fmt)' CMakeLists.txt || die
	else
		sed -i -e '/FMT_INSTALL/d' externals/dynarmic/externals/CMakeLists.txt || die
	fi

	# Unbundle teakra
	sed -i -e '/teakra/d' externals/CMakeLists.txt || die

	# Unbundle zstd
	sed -i -e 's:libzstd_static:${ZSTD_LIBRARIES}:' \
		-e '1ifind_package(PkgConfig REQUIRED)\npkg_check_modules(ZSTD REQUIRED libzstd)' \
		src/common/CMakeLists.txt || die
	sed -i -e '/zstd/d' externals/CMakeLists.txt || die

	# Unbundle enet
	sed -i -e 's:enet:${ENET_LIBRARIES}:' \
		-e '1ifind_package(PkgConfig REQUIRED)\npkg_check_modules(ENET REQUIRED libenet)' \
		src/network/CMakeLists.txt || die
	sed -i -e '/#include.*enet/{s/"/</;s/"/>/}' src/network/*cpp || die
	sed -i -e '/enet/d' externals/CMakeLists.txt || die

	# Unbundle crypto++
	sed -i -e 's:cryptopp:${CRYPTOPP_LIBRARIES}:' \
		-e '1ifind_package(PkgConfig REQUIRED)\npkg_check_modules(CRYPTOPP REQUIRED libcryptopp)' \
		src/dedicated_room/CMakeLists.txt \
		src/core/CMakeLists.txt || die
	sed -i -e '/^# Crypto++/,/add_subdirectory(cryptopp-cmake)/d' externals/CMakeLists.txt || die

	# Unbundle cubeb
	sed -i -e '/CUBEB/,/endif()/d' externals/CMakeLists.txt || die
	if use cubeb; then
		sed -i -e '$afind_package(cubeb REQUIRED)\n' CMakeLists.txt || die
	fi
	# Unbundle cpp-jwt
	sed -i -e '/cpp-jwt/d' externals/CMakeLists.txt || die
	sed -i -e 's/ cpp-jwt/ ssl crypto/' src/web_service/CMakeLists.txt || die

	# Unbundle xbyak
	sed -i -e '/^install(/,/^)$/d' externals/xbyak/CMakeLists.txt || die

	# glslang
	sed -i -e '/^# glslang/,/(glslang)/d' externals/CMakeLists.txt || die
	sed -i -e 's:SPIRV/GlslangToSpv.h:glslang/&:' src/video_core/renderer_vulkan/vk_shader_util.cpp || die
	sed -i -e '/target_include_directories(vulkan-headers/d' externals/CMakeLists.txt || die

	# Do not install dynarmic
	sed -i -e '/^# Install/,$d' externals/dynarmic/CMakeLists.txt || die

	# Do not install zydis
	sed -i '/^install(FILES/,/^install(DIRECTORY/d' \
		externals/dynarmic/externals/zydis/CMakeLists.txt || die
	sed -i -e '/MCL_INSTALL/d' externals/dynarmic/externals/CMakeLists.txt || die

	# do not trigger flags
	sed -i -e 's/-Werror//' externals/sirit/CMakeLists.txt externals/dynarmic/CMakeLists.txt || die
	sed -i -e 's/Wuninitialized/Wno-uninitialized/' externals/catch2/CMake/CatchMiscFunctions.cmake \
		externals/dynarmic/externals/catch/CMake/CatchMiscFunctions.cmake || die
	sed -i -e '/-Werror/d' src/CMakeLists.txt externals/dynarmic/externals/mcl/CMakeLists.txt externals/dynarmic/externals/catch/CMake/CatchMiscFunctions.cmake externals/catch2/CMake/CatchMiscFunctions.cmake

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DCOMPILE_WITH_DWARF=OFF
		-DENABLE_CUBEB=$(usex cubeb)
		-DENABLE_MF=ON
		-DENABLE_OPENAL=$(usex openal)
		-DENABLE_QT=$(usex gui)
		-DENABLE_QT_TRANSLATION=$(use gui && usex nls || echo OFF)
		-DENABLE_SDL2=$(usex sdl)
		-DENABLE_WEB_SERVICE=$(usex telemetry)
		-DGENERATE_QT_TRANSLATION=$(use gui && usex nls || echo OFF)
		-DSIRIT_USE_SYSTEM_SPIRV_HEADERS=ON
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_LIBUSB=ON
		-DUSE_SYSTEM_OPENSSL=ON
		-DUSE_SYSTEM_SDL2=ON
	)
	cmake_src_configure

	# This would be better in src_unpack but it would be unlinked
	mv "${S}"/compatibility_list.json "${BUILD_DIR}"/dist/compatibility_list/ || die
}

src_install() {
	cmake_src_install
	rm -rf "${D}"/usr/$(get_libdir)/cmake
}
