# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Nintendo Switch Emulator"
HOMEPAGE="https://eden-emu.dev"
SRC_URI="
	https://git.eden-emu.dev/eden-emu/eden/archive/v${PV/_/-}.tar.gz -> ${P}.tar.gz
	https://git.crueter.xyz/misc/tzdb_to_nx/releases/download/250725/250725.zip -> nx-tzdb-250725.zip
	https://git.eden-emu.dev/eden-emu/eden/commit/6b01c13975439784cd40cf1810b67350111a41d3.patch ->
		${PN}-0.0.4_rc1-revert-the-latest-Dynarmic-changes.patch
"

S="${WORKDIR}/${PN}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="camera cubeb discord gui lto opengl sdl ssl test usb web-applet web-service wifi"
REQUIRED_USE="
	!gui? ( !camera !discord !opengl !web-applet )
	web-service? ( ssl )
"
RESTRICT="!test? ( test )"

RDEPEND="
	app-arch/lz4
	app-arch/zstd
	dev-libs/libfmt:=
	dev-libs/mcl
	dev-libs/sirit
	dev-util/spirv-tools
	llvm-core/llvm
	media-gfx/renderdoc
	media-libs/libva
	media-libs/opus
	media-video/ffmpeg
	net-libs/enet
	net-libs/mbedtls:3
	sys-libs/zlib

	amd64? (
		dev-libs/zycore-c
		dev-libs/zydis
	)

	camera? ( dev-qt/qtmultimedia:6 )
	cubeb? ( media-libs/cubeb )
	discord? (
		dev-cpp/cpp-httplib:=[ssl]
		dev-libs/discord-rpc
	)
	gui? (
		dev-libs/quazip[qt6]
		dev-qt/qtbase:6[concurrent,dbus,gui,widgets]
	)
	sdl? ( media-libs/libsdl2[haptic,joystick,sound,video] )
	ssl? ( dev-libs/openssl:= )
	usb? ( dev-libs/libusb )
	web-applet? ( dev-qt/qtwebengine:6[widgets] )
	web-service? ( dev-cpp/cpp-httplib:=[ssl] )
	wifi? ( net-wireless/wireless-tools )
"
DEPEND="
	${RDEPEND}
	dev-cpp/nlohmann_json
	dev-cpp/simpleini
	dev-libs/boost:=[context]
	dev-libs/frozen
	dev-libs/unordered_dense
	dev-util/spirv-headers
	dev-util/vulkan-headers
	dev-util/vulkan-utility-libraries
	games-util/gamemode
	media-libs/VulkanMemoryAllocator

	amd64? ( dev-libs/xbyak )
	arm64? ( dev-libs/oaknut )
	x86? ( dev-libs/xbyak )

	web-service? ( dev-cpp/cpp-jwt )

	test? ( dev-libs/oaknut )
"
BDEPEND="
	app-arch/unzip
	dev-util/glslang
	virtual/pkgconfig

	test? ( dev-cpp/catch )
"

PATCHES=(
	"${DISTDIR}/${PN}-0.0.4_rc1-revert-the-latest-Dynarmic-changes.patch"
	"${FILESDIR}/${PN}-0.0.4_rc1-add-a-formatter-for-Dynarmic-IR-Opcode.patch"
)

# [directory]=license
declare -A KEEP_BUNDLED=(
	# Generated or copied files for internal usage
	[bc_decoder]=MPL-2.0
	[cmake-modules]=Boost-1.0
	[FidelityFX-FSR]=MIT
	[glad]=GPL-2+
	[nx_tzdb]="GPL-2+"
	[stb]="MIT public-domain"
	[tz]=BSD-2

	# Configuration for the system library
	[libusb]=GPL-3+
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
		-DCPMUTIL_FORCE_SYSTEM=yes
		-DTITLE_BAR_FORMAT_IDLE="Eden | v${PV/_/-}"
		-DYUZU_TZDB_PATH="${WORKDIR}"
		-DYUZU_USE_FASTER_LD=no

		-DDYNARMIC_ENABLE_LTO=$(usex lto)

		-DBUILD_TESTING=$(usex test)
		-DENABLE_CUBEB=$(usex cubeb)
		-DENABLE_LIBUSB=$(usex usb)
		-DENABLE_OPENGL=$(usex opengl)
		-DENABLE_OPENSSL=$(usex ssl)
		-DENABLE_QT=$(usex gui)
		-DENABLE_SDL2=$(usex sdl)
		-DENABLE_WEB_SERVICE=$(usex web-service)
		-DENABLE_WIFI_SCAN=$(usex wifi)
		-DUSE_DISCORD_PRESENCE=$(usex discord)
		-DYUZU_ENABLE_LTO=$(usex lto)
		-DYUZU_USE_QT_MULTIMEDIA=$(usex camera)
		-DYUZU_USE_QT_WEB_ENGINE=$(usex web-applet)

		-Wno-dev
	)

	cmake_src_configure
}

src_test() {
	cd "${BUILD_DIR}" || die

	./bin/dynarmic_tests || die

	# See https://git.eden-emu.dev/eden-emu/eden/issues/126
	./bin/tests "~Fibers::InterExchange" "~RingBuffer: Threaded Test" || die
}
