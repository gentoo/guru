# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake toolchain-funcs xdg

DESCRIPTION="An emulator for Nintendo Switch"
HOMEPAGE="https://yuzu-emu.org"
SRC_URI="https://github.com/yuzu-emu/yuzu-mainline/archive/dfaab8f6571856ec3c75cfad303a50503d213665.tar.gz -> ${P}.tar.gz
	https://github.com/merryhime/dynarmic/archive/91d1f944e3870e0f3c505b48f5ec00ca9a82b95d.tar.gz -> ${PN}-dynarmic-${PV}.tar.gz
	https://github.com/herumi/xbyak/archive/c306b8e5786eeeb87b8925a8af5c3bf057ff5a90.tar.gz -> ${PN}-xbyak-${PV}.tar.gz
	compatibility-list? ( https://gist.githubusercontent.com/mazes-80/db6fc80114f67dde9d680de6c4d60428/raw/59274e6e641027cb6bf5e2077a899edabaf88904/yuzu-0_p20220725-compatibility_list.json )
	discord? ( https://github.com/discord/discord-rpc/archive/963aa9f3e5ce81a4682c6ca3d136cddda614db33.tar.gz -> ${PN}-discord-${PV}.tar.gz )"
# Dynarmic is not intended to be generic, it is tweaked to fit emulated processor
# xbyak >= 5.96 still not in portage. sent version bump on gentoo BT, can't be in guru as package already exists
# discord-rpc: help appreciated to make ebuild, as I never use it I surely will stick to snapshot download
# TODO host compatibility_list.json

LICENSE="|| ( Apache-2.0 GPL-2+ ) 0BSD BSD GPL-2+ ISC MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+compatibility-list +cubeb discord +qt5 sdl webengine +webservice"

RDEPEND="
	<net-libs/mbedtls-3.1[cmac]
	>=app-arch/zstd-1.5
	>=dev-libs/libfmt-8:=
	>=dev-libs/openssl-1.1:=
	>=media-video/ffmpeg-4.3:=
	app-arch/lz4:=
	dev-libs/boost:=[context]
	dev-libs/sirit
	media-libs/opus
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
		>=dev-libs/inih-52
	)
"
DEPEND="${RDEPEND}
	dev-cpp/cpp-httplib
	>=dev-util/vulkan-headers-1.3.216
"
BDEPEND="
	>=dev-cpp/nlohmann_json-3.8.0
	dev-cpp/robin-map
	dev-util/glslang
	discord? ( >=dev-libs/rapidjson-1.1.0 )
"
S="${WORKDIR}"/yuzu-mainline-dfaab8f6571856ec3c75cfad303a50503d213665
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
	mv "${WORKDIR}"/xbyak* "${S}/externals/xbyak/xbyak" || die
	mv "${WORKDIR}"/dynarmic*/* "${S}/externals/dynarmic" || die
	if use discord; then
		mv "${WORKDIR}"/discord*/* "${S}/externals/discord-rpc" || die
	fi
}

src_prepare() {
	# Allow skip submodule downloading
	rm .gitmodules || die

	if ! use discord; then
		sed -i -e '/discord-rpc/d' externals/CMakeLists.txt || die
	else
		# Unbundle discord rapidjson
		sed -i '/NOT RAPIDJSONTEST/,/endif(NOT RAPIDJSONTEST)/d;/find_file(RAPIDJSON/d;s:\${RAPIDJSON}:"/usr/include/rapidjson":' \
			externals/discord-rpc/CMakeLists.txt || die
	fi

	cmake_src_prepare
}

src_configure() {
	local -a mycmakeargs=(
		# Libraries are private and rely on circular dependency resolution.
		-DBUILD_SHARED_LIBS=OFF # dynarmic
		-DDYNARMIC_NO_BUNDLED_ROBIN_MAP=ON
		-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=$(usex compatibility-list)
		-DENABLE_CUBEB=$(usex cubeb)
		-DENABLE_QT=$(usex qt5)
		-DENABLE_QT_TRANSLATION=$(usex qt5)
		-DENABLE_SDL2=$(usex sdl)
		-DENABLE_WEB_SERVICE=$(usex webservice)
		-DUSE_DISCORD_PRESENCE=$(usex discord)
		-DYUZU_TESTS=OFF
		-DYUZU_USE_BUNDLED_OPUS=OFF
		-DYUZU_USE_EXTERNAL_SDL2=OFF
		-DYUZU_USE_QT_WEB_ENGINE=$(usex webengine)
	)

	cmake_src_configure

	if use compatibility-list; then
		cp "${DISTDIR}"/${P}-compatibility_list.json "${BUILD_DIR}"/dist/compatibility_list/ || die
	fi
}
