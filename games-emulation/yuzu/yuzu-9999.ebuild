# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 toolchain-funcs xdg

DESCRIPTION="An emulator for Nintendo Switch"
HOMEPAGE="https://yuzu-emu.org"
EGIT_REPO_URI="https://github.com/yuzu-emu/yuzu"
EGIT_SUBMODULES=( '*' '-ffmpeg' '-inih' '-libressl' '-libusb' '-opus' '-SDL' )
# TODO '-libzip' when boxcat feature is reintroduced
# TODO '-xbyak' wait for bump in tree
# TODO cubeb auto-links to jack, pulse, alsa .., allow determining cubeb output
#      media-libs/cubeb would benefit to a lot of packages: dolphin-emu, firefox, citra, self, ...
# TODO many submodules produce static libraries which forces to unset BUILD_SHARED_LIBS
#      this may be better to generate shared libraries and install them under /usr/$(get_libdir)/yuzu

LICENSE="|| ( Apache-2.0 GPL-2+ ) 0BSD BSD GPL-2+ ISC MIT
	!system-vulkan? ( Apache-2.0 )"
SLOT="0"
KEYWORDS=""
IUSE="+boxcat +compatibility-list +cubeb discord +qt5 sdl system-vulkan webengine +webservice"

RDEPEND="
	>=app-arch/lz4-1.8:=
	>=app-arch/zstd-1.5
	>=dev-libs/boost-1.73:=[context]
	>=dev-libs/libfmt-8:=
	>=dev-libs/openssl-1.1:=
	>=media-libs/opus-1.3
	media-video/ffmpeg:=
	>=sys-libs/zlib-1.2
	virtual/libusb:1
	qt5? (
		>=dev-qt/qtcore-5.15:5
		>=dev-qt/qtgui-5.15:5
		>=dev-qt/qtwidgets-5.15:5
	)
	sdl? (
		>=media-libs/libsdl2-2.0.16
		>=dev-libs/inih-52
	)
"
DEPEND="${RDEPEND}
	system-vulkan? (
		>=dev-util/vulkan-headers-1.2.180
	)
"
BDEPEND="
	>=dev-cpp/catch-2.13:0
	>=dev-cpp/nlohmann_json-3.8.0
	dev-util/glslang
	discord? ( >=dev-libs/rapidjson-1.1.0 )
"
REQUIRED_USE="boxcat? ( webservice ) || ( qt5 sdl )"

PATCHES=( "${FILESDIR}"/${P}-assert.patch )

pkg_setup() {
	if tc-is-gcc; then
		[[ "$(gcc-major-version)" -lt 11 ]] && \
			die "You need gcc version 11 or clang to compile this package"
	fi
	grep -q 'ThreadEngineStarter<void>' /usr/include/qt5/QtConcurrent/qtconcurrentthreadengine.h \
		|| die "add user patch for dev-qt/qtconcurrent: https://github.com/qt/qtbase/commit/659f7a06e91c04b239e3f4c0bcfccbe3581af1c3.diff"
}

src_unpack() {
	if use system-vulkan; then
		EGIT_SUBMODULES+=('-Vulkan-Headers')
	fi

	git-r3_src_unpack

	# Do not fetch via sources because this file always changes
	use compatibility-list && curl https://api.yuzu-emu.org/gamedb/ > "${S}"/compatibility_list.json
}

src_prepare() {
	# headers is not a valid boost component
	sed -i -e '/find_package(Boost/{s/headers //;s/CONFIG //}' CMakeLists.txt || die

	# Allow skip submodule downloading
	rm .gitmodules || die

	# Unbundle inih
	sed -i -e '/inih/d' externals/CMakeLists.txt || die
	sed -i -e '1afind_package(PkgConfig REQUIRED)\npkg_check_modules(INIH REQUIRED INIReader)' \
		-e '/target_link_libraries/s/inih/${INIH_LIBRARIES}/' src/yuzu_cmd/CMakeLists.txt || die
	sed -i -e 's:inih/cpp/::' src/yuzu_cmd/config.cpp || die

	# Unbundle xbyak ( uncomment when xbyak version is ok or never as it is only headers )
	# sed -i -e '/target_include_directories(xbyak/s:./xbyak/xbyak:/usr/include/xbyak/:' externals/CMakeLists.txt

	if use system-vulkan; then # Unbundle vulkan headers
		sed -i -e 's:../../externals/Vulkan-Headers/include:/usr/include/vulkan/:' src/video_core/CMakeLists.txt src/yuzu/CMakeLists.txt src/yuzu_cmd/CMakeLists.txt || die
		sed -i -e '/VK_ERROR_INCOMPATIBLE_VERSION_KHR/d' src/video_core/vulkan_common/vulkan_wrapper.cpp || die
	fi

	# Unbundle discord rapidjson
	sed -i '/NOT RAPIDJSONTEST/,/endif(NOT RAPIDJSONTEST)/d;/find_file(RAPIDJSON/d;s:\${RAPIDJSON}:"/usr/include/rapidjson":' externals/discord-rpc/CMakeLists.txt || die

	# Workaround: GenerateSCMRev fails
	sed -i -e "s/@GIT_BRANCH@/${EGIT_BRANCH:-master}/" \
		-e "s/@GIT_REV@/$(git rev-parse --short HEAD)/" \
		-e "s/@GIT_DESC@/$(git describe --always --long)/" \
		src/common/scm_rev.cpp.in || die

	cmake_src_prepare
}

src_configure() {
	local -a mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=$(usex compatibility-list)
		-DENABLE_CUBEB=$(usex cubeb)
		-DENABLE_QT=$(usex qt5)
		-DENABLE_QT_TRANSLATION=$(usex qt5)
		-DENABLE_SDL2=$(usex sdl)
		-DENABLE_WEB_SERVICE=$(usex webservice)
		-DUSE_DISCORD_PRESENCE=$(usex discord)
		# -DYUZU_ENABLE_BOXCAT=$(usex boxcat) # feature removed
		# upstream is now fixing it, will be reintroduced
		-DYUZU_USE_EXTERNAL_SDL2=OFF
		-DYUZU_USE_QT_WEB_ENGINE=$(usex webengine)
	)

	cmake_src_configure

	# This would be better in src_unpack but it would be unlinked
	if use compatibility-list; then
		mv "${S}"/compatibility_list.json "${BUILD_DIR}"/dist/compatibility_list/ || die
	fi
}
