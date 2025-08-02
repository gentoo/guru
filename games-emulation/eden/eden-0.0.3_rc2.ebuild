# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Nintendo Switch Emulator"
HOMEPAGE="https://eden-emu.dev"
SRC_URI="https://git.eden-emu.dev/eden-emu/eden/archive/v${PV/_/-}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="camera cubeb discord gui lto sdl ssl test web-applet wifi"
REQUIRED_USE="!gui? ( !camera !discord !web-applet )"
RESTRICT="!test? ( test )"

RDEPEND="
	app-arch/lz4
	app-arch/zstd
	dev-cpp/cpp-httplib:=[ssl]
	dev-libs/libfmt:=
	dev-libs/libusb
	dev-libs/sirit
	dev-util/spirv-tools
	llvm-core/llvm
	media-libs/libva
	media-libs/opus
	media-video/ffmpeg
	net-libs/enet
	net-libs/mbedtls:0[cmac]
	sys-libs/zlib

	amd64? ( dev-libs/dynarmic )
	arm64? ( dev-libs/dynarmic )

	camera? ( dev-qt/qtmultimedia:6 )
	cubeb? ( media-libs/cubeb )
	discord? (
		dev-libs/discord-rpc
		dev-qt/qtbase:6[network]
	)
	gui? (
		dev-libs/quazip[qt6]
		dev-qt/qtbase:6[concurrent,dbus,widgets]
	)
	sdl? ( media-libs/libsdl2 )
	ssl? ( dev-libs/openssl:= )
	web-applet? ( dev-qt/qtwebengine:6[widgets] )
	wifi? ( net-wireless/wireless-tools )
"
DEPEND="
	${RDEPEND}
	dev-cpp/cpp-jwt
	dev-cpp/nlohmann_json
	dev-cpp/simpleini
	dev-libs/boost:=[context]
	dev-util/vulkan-headers
	dev-util/vulkan-utility-libraries
	games-util/gamemode
	media-gfx/renderdoc
	media-libs/VulkanMemoryAllocator
	sys-libs/timezone-data

	amd64? ( dev-libs/xbyak )
	arm64? ( dev-libs/oaknut )
	x86? ( dev-libs/xbyak )
"
BDEPEND="
	dev-build/make
	dev-vcs/git
	sys-apps/coreutils
	virtual/pkgconfig
	test? ( dev-cpp/catch )
"

PATCHES=(
	"${FILESDIR}/${PN}-0.0.3_rc2-add-a-missing-include-for-the-log-header.patch"
	"${FILESDIR}/${PN}-0.0.3_rc2-move-the-definition-of-create_target_directory_group.patch"
	"${FILESDIR}/${PN}-0.0.3_rc2-relax-the-dependency-on-httplib.patch"
	"${FILESDIR}/${PN}-0.0.3_rc2-use-the-system-Boost-library.patch"
	"${FILESDIR}/${PN}-0.0.3_rc2-use-the-system-mbedtls-library.patch"
	"${FILESDIR}/${PN}-0.0.3_rc2-use-the-system-QuaZip-library.patch"
	"${FILESDIR}/${PN}-0.0.3_rc2-use-the-system-sirit-library.patch"
)

# [directory]=license
declare -A KEEP_BUNDLED=(
	# Generated or copied files for internal usage
	[bc_decoder]=MPL-2.0
	[cmake-modules]=Boost-1.0
	[FidelityFX-FSR]=MIT
	[glad]=GPL-2+
	[microprofile]=public-domain
	[nx_tzdb]="GPL-2+ MIT"
	[stb]="MIT public-domain"
	[tz]=BSD-2
)

add_bundled_licenses() {
	for license in "${KEEP_BUNDLED[@]}"; do
		if [[ -n "$license" ]]; then
			LICENSE+=" ${license}"
		fi
	done
}
add_bundled_licenses

src_prepare() {
	local s remove=()
	for s in externals/*; do
		[[ -f ${s} ]] && continue
		if ! has "${s#externals/}" "${!KEEP_BUNDLED[@]}"; then
			remove+=( "${s}" )
		fi
	done

	einfo "removing sources: ${remove[*]}"
	rm -r "${remove[@]}" || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DYUZU_CHECK_SUBMODULES=no
		-DYUZU_ENABLE_PORTABLE=no
		-DYUZU_USE_BUNDLED_FFMPEG=no
		-DYUZU_USE_BUNDLED_SDL2=no
		-DYUZU_USE_EXTERNAL_SDL2=no
		-DYUZU_USE_EXTERNAL_VULKAN_HEADERS=no
		-DYUZU_USE_EXTERNAL_VULKAN_SPIRV_TOOLS=no
		-DYUZU_USE_EXTERNAL_VULKAN_UTILITY_LIBRARIES=no
		-DYUZU_USE_PRECOMPILED_HEADERS=no
		-DTZDB2NX_VERSION=gentoo
		-DTZDB2NX_ZONEINFO_DIR=/usr/share/zoneinfo

		-DENABLE_CUBEB=$(usex cubeb)
		-DENABLE_OPENSSL=$(usex ssl)
		-DENABLE_QT=$(usex gui)
		-DENABLE_SDL2=$(usex sdl)
		-DENABLE_WIFI_SCAN=$(usex wifi)
		-DUSE_DISCORD_PRESENCE=$(usex discord)
		-DYUZU_ENABLE_LTO=$(usex lto)
		-DYUZU_TESTS=$(usex test)
		-DYUZU_USE_QT_MULTIMEDIA=$(usex camera)
		-DYUZU_USE_QT_WEB_ENGINE=$(usex web-applet)

		# Support for this flag is broken by upstream
		-DENABLE_WEB_SERVICE=yes

		-Wno-dev
	)

	cmake_src_configure
}

src_test() {
	cd "${BUILD_DIR}" || die

	# See https://git.eden-emu.dev/eden-emu/eden/issues/126
	./bin/tests "~Fibers::InterExchange" "~RingBuffer: Threaded Test"
}
