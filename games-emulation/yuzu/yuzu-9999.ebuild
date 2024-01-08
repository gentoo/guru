# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 toolchain-funcs xdg

DESCRIPTION="An emulator for Nintendo Switch"
HOMEPAGE="https://yuzu-emu.org"
EGIT_REPO_URI="https://github.com/yuzu-emu/yuzu-mainline"
EGIT_SUBMODULES=( '-*' 'dynarmic' 'sirit' 'xbyak' 'tzdb_to_nx'
	              'externals/nx_tzdb/tzdb_to_nx/externals/tz/tz' 'VulkanMemoryAllocator' )
# Dynarmic is not intended to be generic, it is tweaked to fit emulated processor
# TODO wait 'xbyak' waiting version bump. see #860816

LICENSE="|| ( Apache-2.0 GPL-2+ ) 0BSD BSD GPL-2+ ISC MIT
	!system-vulkan? ( Apache-2.0 )"
SLOT="0"
KEYWORDS=""
IUSE="+compatibility-list +cubeb discord +qt5 sdl +system-libfmt +system-vulkan test webengine +webservice"

RDEPEND="
	<net-libs/mbedtls-3.1[cmac]
	>=app-arch/zstd-1.5
	>=dev-libs/inih-52
	>=dev-libs/openssl-1.1:=
	>=media-video/ffmpeg-4.3:=
	>=net-libs/enet-1.3
	app-arch/lz4:=
	dev-libs/boost:=[context]
	media-libs/opus
	>=media-libs/vulkan-loader-1.3.274
	sys-libs/zlib
	virtual/libusb:1
	cubeb? ( media-libs/cubeb )
	qt5? (
		>=dev-qt/qtcore-5.15:5
		>=dev-qt/qtgui-5.15:5
		>=dev-qt/qtmultimedia-5.15:5
		>=dev-qt/qtwidgets-5.15:5
		>=dev-qt/qtdbus-5.15:5
		>=dev-qt/qtconcurrent-5.15:5
		>=dev-qt/linguist-tools-5.15:5
		webengine? ( >=dev-qt/qtwebengine-5.15:5 )
	)
	sdl? ( >=media-libs/libsdl2-2.28 )
	system-libfmt? ( >=dev-libs/libfmt-9:= )
"
DEPEND="${RDEPEND}
	dev-cpp/cpp-httplib
	dev-cpp/cpp-jwt
	system-vulkan? ( >=dev-util/vulkan-headers-1.3.274
		dev-util/spirv-headers
		x11-libs/libX11
	)
	test? ( >dev-cpp/catch-3:0 )
"
BDEPEND="
	>=dev-cpp/nlohmann_json-3.8.0
	dev-cpp/simpleini
	dev-cpp/robin-map
	dev-util/glslang
	discord? ( >=dev-libs/rapidjson-1.1.0 )
"
REQUIRED_USE="|| ( qt5 sdl ) discord? ( webservice )"
RESTRICT="!test? ( test )"

pkg_setup() {
	if tc-is-gcc; then
		[[ "$(gcc-major-version)" -lt 11 ]] && \
			die "You need gcc version 11 or clang to compile this package"
	fi
}

src_unpack() {
	if use discord; then
		EGIT_SUBMODULES+=('discord-rpc')
	fi

	if use !system-vulkan; then
		EGIT_SUBMODULES+=('Vulkan-Headers')
	fi

	if use test; then
		EGIT_SUBMODULES+=('Catch2')
	fi

	git-r3_src_unpack

	# Do not fetch via sources because this file always changes
	use compatibility-list && curl https://api.yuzu-emu.org/gamedb/ > "${S}"/compatibility_list.json
}

src_prepare() {
	# temporary fix
	sed -i -e '/Werror/d' src/CMakeLists.txt || die

	# Unbundle mbedtls
	sed -i -e '/mbedtls/d' -e '/^if (NOT MSVC)/,/endif()/d' externals/CMakeLists.txt || die
	sed -i -e 's/mbedtls/& mbedcrypto mbedx509/' \
		src/dedicated_room/CMakeLists.txt \
		src/core/CMakeLists.txt || die

	# Workaround: GenerateSCMRev fails
	sed -i -e "s/@GIT_BRANCH@/${EGIT_BRANCH:-master}/" \
		-e "s/@GIT_REV@/$(git rev-parse --short HEAD)/" \
		-e "s/@GIT_DESC@/$(git describe --always --long)/" \
		src/common/scm_rev.cpp.in || die

	if ! use discord; then
		sed -i -e '/^if.*discord-rpc/,/^endif()/d' externals/CMakeLists.txt || die
	else
		# Unbundle discord rapidjson
		sed -i -e '/NOT RAPIDJSONTEST/,/endif(NOT RAPIDJSONTEST)/d' \
		-e '/find_file(RAPIDJSON/d' -e 's:\${RAPIDJSON}:"/usr/include/rapidjson":' \
			externals/discord-rpc/CMakeLists.txt || die
	fi

	# Unbundle cubeb
	sed -i '/^if.*cubeb/,/^endif()/d' externals/CMakeLists.txt || die

	# Unbundle cpp-httplib
	sed -i -e '/httplib/s/ 0.12//' CMakeLists.txt || die
	sed -i -e '/^# httplib/,/^endif()/d' externals/CMakeLists.txt || die

	# Unbundle enet
	sed -i -e '/^if.*enet/,/^endif()/d' externals/CMakeLists.txt || die
	sed -i -e '/enet\/enet\.h/{s/"/</;s/"/>/}' src/network/network.cpp || die

	# LZ4 temporary fix: https://github.com/yuzu-emu/yuzu/pull/9054/commits/a8021f5a18bc5251aef54468fa6033366c6b92d9
	sed -i 's/lz4::lz4/lz4/' src/common/CMakeLists.txt || die

	if ! use system-libfmt; then # libfmt >= 9
		sed -i '/fmt.*REQUIRED/d' CMakeLists.txt || die
	fi

	# Allow compiling using older glslang
	if use system-vulkan -a has_version '<dev-util/glslang-1.3.256'; then
		sed -i '/Vulkan/s/256/250/' CMakeLists.txt
	fi

	cmake_src_prepare
}

src_configure() {
	local -a mycmakeargs=(
		# Libraries are private and rely on circular dependency resolution.
		-DBUILD_SHARED_LIBS=OFF # dynarmic
		-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=$(usex compatibility-list)
		-DENABLE_CUBEB=$(usex cubeb)
		-DENABLE_LIBUSB=ON
		-DENABLE_QT=$(usex qt5)
		-DENABLE_QT_TRANSLATION=$(usex qt5)
		-DENABLE_SDL2=$(usex sdl)
		-DENABLE_WEB_SERVICE=$(usex webservice)
		-DSIRIT_USE_SYSTEM_SPIRV_HEADERS=$([ use system-vulkan ] && echo OFF || echo ON)
		-DUSE_DISCORD_PRESENCE=$(usex discord)
		-DYUZU_TESTS=$(usex test)
		-DYUZU_USE_EXTERNAL_VULKAN_HEADERS=$([ use system-vulkan ] && echo ON || echo OFF)
		-DYUZU_USE_EXTERNAL_SDL2=OFF
		-DYUZU_CHECK_SUBMODULES=false
		-DYUZU_USE_QT_WEB_ENGINE=$(usex webengine)
	)

	cmake_src_configure

	# This would be better in src_unpack but it would be unlinked
	if use compatibility-list; then
		mv "${S}"/compatibility_list.json "${BUILD_DIR}"/dist/compatibility_list/ || die
	fi
}
