# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3 flag-o-matic toolchain-funcs xdg

DESCRIPTION="An emulator for Nintendo Switch"
HOMEPAGE="https://yuzu-emu.org"
EGIT_REPO_URI="https://github.com/yuzu-emu/yuzu"
EGIT_SUBMODULES=( '*' '-ffmpeg' '-inih' '-libressl' '-libusb' '-libzip' '-opus' '-SDL' '-Vulkan-Headers' )
# TODO '-xbyak' wait for bump in tree
# TODO cubeb auto-links to jack, pulse, alsa .., allow determining cubeb output
#      media-libs/cubeb would benefit to a lot of packages: dolphin-emu, firefox, citra, self, ...
# TODO many submodules produce static libraries which forces to unset BUILD_SHARED_LIBS
#      this may be better to generate shared libraries and install them under /usr/$(get_libdir)/yuzu

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+boxcat +cubeb discord +qt5 sdl webengine +webservice"

DEPEND="
	discord? ( >=dev-libs/rapidjson-1.1.0 )
	qt5? (
		>=dev-qt/qtgui-5.15
		>=dev-qt/qtwidgets-5.15
	)
	sdl? (
		>=media-libs/libsdl2-2.0.14
		>=dev-libs/inih-52
	)
	>=app-arch/lz4-1.8
	>=app-arch/zstd-1.5
	>=dev-cpp/catch-2.13:0
	>=dev-cpp/nlohmann_json-3.8.0
	>=dev-libs/boost-1.73:=[context]
	>=dev-libs/libfmt-7.1.0
	>=dev-libs/libzip-1.5
	>=media-libs/opus-1.3.1
	>=sys-libs/zlib-1.2
	dev-util/vulkan-headers
	virtual/libusb:1
"
#	>=dev-libs/xbyak-5.96
RDEPEND="${DEPEND}"
REQUIRED_USE="boxcat? ( webservice ) || ( qt5 sdl )"

PATCHES=( "${FILESDIR}"/${P}-assert.patch )

pkg_setup() {
	if [ tc-is-gcc -a $(gcc-major-version) -lt 10 ]; then
		die "You need gcc version 10 or clang to compile this package"
	fi
}

# May fetch this file from src_unpack to provide compatibility list support
# curl https://api.yuzu-emu.org/gamedb/ > "${S}"/compatibility_list.json

src_prepare() {
	# Set yuzu dev flags
	filter-flags '-*'
	append-cflags '-O3 -DNDEBUG'
	append-cxxflags '-O3 -DNDEBUG'

	# headers is not a valid boost component
	sed -i -e '/find_package(Boost/{s/headers //;s/CONFIG //}' CMakeLists.txt || die

	# Allow skip submodule downloading
	rm .gitmodules

	# unbundle opus (thx to https://github.com/Alex-Aralis/yuzu-overlay/blob/master/games-emulation/yuzu/files/unbundle-opus.patch)
	sed -i -e "s!add_subdirectory(opus)!add_library(opus INTERFACE)\ntarget_include_directories(opus SYSTEM INTERFACE /usr/include/opus)\ntarget_link_libraries(opus INTERFACE /usr/$(get_libdir)/libopus.so)!" externals/CMakeLists.txt || die

	# Fix libzip detection
	sed -i -e '/Libzip/s:.*:include(find-modules/FindLibzip.cmake)\n&:' externals/CMakeLists.txt || die

	# Unbundle inih
	sed -i -e '/inih/d' externals/CMakeLists.txt || die
	sed -i -e '1afind_package(PkgConfig REQUIRED)\npkg_check_modules(INIH REQUIRED INIReader)' \
		-e '/target_link_libraries/s/inih/${INIH_LIBRARIES}/' src/yuzu_cmd/CMakeLists.txt || die
	sed -i -e 's:inih/cpp/::' src/yuzu_cmd/config.cpp || die

	# Unbundle xbyak ( uncomment when xbyak version is ok or never as it is only headers )
	# sed -i -e '/target_include_directories(xbyak/s:./xbyak/xbyak:/usr/include/xbyak/:' externals/CMakeLists.txt

	# Unbundle vulkan headers
	sed -i -e 's:../../externals/Vulkan-Headers/include:/usr/include/vulkan/:' src/video_core/CMakeLists.txt src/yuzu/CMakeLists.txt src/yuzu_cmd/CMakeLists.txt || die
	sed -i -e '/VK_ERROR_INCOMPATIBLE_VERSION_KHR/d' src/video_core/vulkan_common/vulkan_wrapper.cpp || die

	# Unbundle discord rapidjson
	sed -i '/NOT RAPIDJSONTEST/,/endif(NOT RAPIDJSONTEST)/d;/find_file(RAPIDJSON/d;s:\${RAPIDJSON}:"/usr/include/rapidjson":' externals/discord-rpc/CMakeLists.txt || die

	# Force disable bundled sdl2, use 2.0.14 in tree
	if use sdl; then
		sed -i '/find_package(SDL2/{s/2.0.15/2.0.14/;s/ QUIET//}' CMakeLists.txt || die
		sed -i '/PS5_RUMBLE/d' src/input_common/sdl/sdl_impl.cpp
	fi

	cmake_src_prepare
}

src_configure() {
	local -a mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DENABLE_CUBEB=$(usex cubeb)
		-DENABLE_QT=$(usex qt5)
		-DENABLE_QT_TRANSLATION=$(usex qt5)
		-DENABLE_SDL2=$(usex sdl)
		-DENABLE_WEB_SERVICE=$(usex webservice)
		-DUSE_DISCORD_PRESENCE=$(usex discord)
		-DYUZU_ALLOW_SYSTEM_SDL2=$(usex sdl)
		-DYUZU_ENABLE_BOXCAT=$(usex boxcat)
		-DYUZU_USE_QT_WEB_ENGINE=$(usex webengine)
		-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF
	)
	cmake_src_configure

	## This would be better in src_unpack but it would be unlinked
	#mv "${S}"/compatibility_list.json "${BUILD_DIR}"/dist/compatibility_list/ || die
}
