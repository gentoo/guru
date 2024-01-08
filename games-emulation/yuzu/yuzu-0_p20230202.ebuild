# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake toolchain-funcs xdg

DESCRIPTION="An emulator for Nintendo Switch"
HOMEPAGE="https://yuzu-emu.org"
SRC_URI="https://github.com/yuzu-emu/yuzu-mainline/archive/d5f6201521cdfd0be09a187d62f95d3a38f18c3e.tar.gz
		-> ${P}.tar.gz
	https://github.com/merryhime/dynarmic/archive/befe547d5631024a70d81d2ccee808bbfcb3854e.tar.gz
		-> ${PN}-dynarmic-${PV}.tar.gz
	https://github.com/herumi/xbyak/archive/a1ac3750f9a639b5a6c6d6c7da4259b8d6790989.tar.gz
		-> ${PN}-xbyak-${PV}.tar.gz
	https://github.com/yuzu-emu/sirit/archive/ab75463999f4f3291976b079d42d52ee91eebf3f.tar.gz -> ${PN}-sirit-${PV}.tar.gz
	compatibility-list? (
		https://gist.githubusercontent.com/mazes-80/e3f1518e67c3292656a9055ba338994f/raw/b975f96366294d9cf65f844ed8df9189a488463d/${P}-compatibility_list.json
	)
	discord? (
		https://github.com/yuzu-emu/discord-rpc/archive/20cc99aeffa08a4834f156b6ab49ed68618cf94a.tar.gz
		-> ${PN}-discord-${PV}.tar.gz
	)"
# Dynarmic is not intended to be generic, it is tweaked to fit emulated processor
# TODO wait 'xbyak' waiting version bump. see #860816

LICENSE="|| ( Apache-2.0 GPL-2+ ) 0BSD BSD GPL-2+ ISC MIT
	!system-vulkan? ( Apache-2.0 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+compatibility-list +cubeb discord +qt5 sdl +system-vulkan webengine webservice"

RDEPEND="
	<net-libs/mbedtls-3.1[cmac]
	>=app-arch/zstd-1.5
	>=dev-libs/inih-52
	>=dev-libs/libfmt-9:=
	>=dev-libs/openssl-1.1:=
	>=media-video/ffmpeg-4.3:=
	>=net-libs/enet-1.3
	app-arch/lz4:=
	dev-libs/boost:=[context]
	media-libs/opus
	media-libs/vulkan-loader
	sys-libs/zlib
	virtual/libusb:1
	cubeb? ( media-libs/cubeb )
	qt5? (
		>=dev-qt/qtcore-5.15:5
		>=dev-qt/qtgui-5.15:5
		>=dev-qt/qtmultimedia-5.15:5
		>=dev-qt/qtwidgets-5.15:5
	)
	sdl? (
		>=media-libs/libsdl2-2.0.18
	)
"
DEPEND="${RDEPEND}
	dev-cpp/cpp-httplib
	dev-cpp/cpp-jwt
	system-vulkan? ( >=dev-util/vulkan-headers-1.3.236 )
"
BDEPEND="
	>=dev-cpp/nlohmann_json-3.8.0
	dev-cpp/robin-map
	dev-util/glslang
	discord? ( >=dev-libs/rapidjson-1.1.0 )
"
S="${WORKDIR}"/yuzu-mainline-d5f6201521cdfd0be09a187d62f95d3a38f18c3e
PATCHES=( "${FILESDIR}/${P}.patch" )

REQUIRED_USE="|| ( qt5 sdl )"

pkg_setup() {
	if tc-is-gcc; then
		[[ "$(gcc-major-version)" -lt 11 ]] && \
			die "You need gcc version 11 or clang to compile this package"
	fi
}

src_unpack() {
	default
	mv "${WORKDIR}"/dynarmic*/* "${S}/externals/dynarmic" || die
	mv "${WORKDIR}"/sirit*/* "${S}/externals/sirit" || die
	mv "${WORKDIR}"/xbyak*/* "${S}/externals/xbyak" || die
	if use discord; then
		mv "${WORKDIR}"/discord*/* "${S}/externals/discord-rpc" || die
	fi
}

src_prepare() {
	# Allow skip submodule downloading
	rm .gitmodules || die

	if ! use discord; then
		sed -i -e '/^if.*discord-rpc/,/^endif()/d' externals/CMakeLists.txt || die
	else
		# Unbundle discord rapidjson
		sed -i -e '/NOT RAPIDJSONTEST/,/endif(NOT RAPIDJSONTEST)/d' \
			-e '/find_file(RAPIDJSON/d' -e 's:\${RAPIDJSON}:"/usr/include/rapidjson":' \
			externals/discord-rpc/CMakeLists.txt || die
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
		-DSIRIT_USE_SYSTEM_SPIRV_HEADERS=yes
		-DUSE_DISCORD_PRESENCE=$(usex discord)
		-DYUZU_TESTS=OFF
		-DYUZU_USE_EXTERNAL_VULKAN_HEADERS=$(use system-vulkan no yes)
		-DYUZU_USE_EXTERNAL_SDL2=OFF
		-DYUZU_USE_QT_WEB_ENGINE=$(usex webengine)
	)

	cmake_src_configure

	if use compatibility-list; then
		cp "${DISTDIR}"/${P}-compatibility_list.json "${BUILD_DIR}"/dist/compatibility_list/ || die
	fi
}
