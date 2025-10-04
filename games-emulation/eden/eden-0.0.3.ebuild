# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Nintendo Switch Emulator"
HOMEPAGE="https://eden-emu.dev"
SRC_URI="
	https://git.eden-emu.dev/eden-emu/eden/archive/v${PV/_/-}.tar.gz -> ${P}.tar.gz
	https://github.com/crueter-archive/tzdb_to_nx/releases/download/250725/250725.zip -> nx-tzdb-250725.zip
"

S="${WORKDIR}/${PN}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="camera cubeb discord gui lto opengl sdl ssl test web-applet web-service wifi"
REQUIRED_USE="
	!gui? ( !camera !discord !opengl !web-applet )
	web-service? ( ssl )
"
RESTRICT="!test? ( test )"

RDEPEND="
	app-arch/lz4
	app-arch/zstd
	dev-libs/libfmt:=
	dev-libs/libusb
	dev-libs/mcl
	dev-libs/sirit
	dev-util/spirv-tools
	llvm-core/llvm
	media-gfx/renderdoc
	media-libs/libva
	media-libs/opus
	media-video/ffmpeg
	net-libs/enet
	net-libs/mbedtls:0[cmac]
	sys-libs/zlib

	amd64? (
		dev-libs/zycore-c
		dev-libs/zydis
	)

	camera? ( dev-qt/qtmultimedia:6 )
	cubeb? ( media-libs/cubeb )
	discord? (
		dev-libs/discord-rpc
		dev-qt/qtbase:6[network]
	)
	gui? (
		dev-libs/quazip[qt6]
		dev-qt/qtbase:6[concurrent,dbus,gui,widgets]
	)
	sdl? ( media-libs/libsdl2[haptic,joystick,sound,video] )
	ssl? ( dev-libs/openssl:= )
	web-applet? ( dev-qt/qtwebengine:6[widgets] )
	web-service? ( dev-cpp/cpp-httplib:=[ssl] )
	wifi? ( net-wireless/wireless-tools )
"
DEPEND="
	${RDEPEND}
	dev-cpp/nlohmann_json
	dev-cpp/simpleini
	dev-libs/boost:=[context]
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
"
BDEPEND="
	app-arch/unzip
	dev-util/glslang
	virtual/pkgconfig

	test? (
		dev-cpp/catch
		dev-libs/oaknut
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-0.0.3-fix-compilation-errors.patch"
	"${FILESDIR}/${PN}-0.0.3-make-the-dependency-on-mcl-global.patch"
	"${FILESDIR}/${PN}-0.0.3-make-the-dependency-on-xbyak-global.patch"
	"${FILESDIR}/${PN}-0.0.3-use-the-bundled-dynarmic-library.patch"
	"${FILESDIR}/${PN}-0.0.3-use-the-system-discord-rpc-library.patch"
	"${FILESDIR}/${PN}-0.0.3-use-the-system-mbedtls-library.patch"
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

	mkdir -p "${S}/.cache/cpm/nx_tzdb" || die
	mv "${WORKDIR}/zoneinfo" "$_/250725" || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DTITLE_BAR_FORMAT_IDLE="Eden | v${PV/_/-}"
		-DYUZU_CHECK_SUBMODULES=no
		-DYUZU_ENABLE_PORTABLE=no
		-DYUZU_USE_BUNDLED_FFMPEG=no
		-DYUZU_USE_CPM=no
		-DYUZU_USE_EXTERNAL_SDL2=no
		-DYUZU_USE_EXTERNAL_VULKAN_HEADERS=no
		-DYUZU_USE_EXTERNAL_VULKAN_SPIRV_TOOLS=no
		-DYUZU_USE_EXTERNAL_VULKAN_UTILITY_LIBRARIES=no
		-DYUZU_USE_FASTER_LD=no
		-DYUZU_USE_PRECOMPILED_HEADERS=no

		-DDYNARMIC_USE_PRECOMPILED_HEADERS=no

		-DBUILD_TESTING=$(usex test)
		-DENABLE_CUBEB=$(usex cubeb)
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

		-DCPMUTIL_FORCE_SYSTEM=yes
		-Dnx_tzdb_FORCE_BUNDLED=yes

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
