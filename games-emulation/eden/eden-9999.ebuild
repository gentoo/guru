# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg toolchain-funcs optfeature

_TZDB_VER=121125

_COMMON_SRC="
	https://git.eden-emu.dev/eden-emu/tzdb_to_nx/releases/download/${_TZDB_VER}/${_TZDB_VER}.tar.gz ->
		nx-tzdb-${_TZDB_VER}.tar.gz
"

DESCRIPTION="Nintendo Switch Emulator"
HOMEPAGE="https://eden-emu.dev"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.eden-emu.dev/eden-emu/eden.git"
	EGIT_CLONE_TYPE="shallow"
	EGIT_CHECKOUT_DIR="${WORKDIR}/${PN}"

	SRC_URI="${_COMMON_SRC}"
else
	KEYWORDS="~amd64 ~arm64"
	SRC_URI="
		${_COMMON_SRC}
		https://git.eden-emu.dev/eden-emu/eden/archive/v${PV/_/-}.tar.gz -> ${P}.tar.gz
		https://git.eden-emu.dev/eden-emu/eden/pulls/3967.patch -> ${PN}-0.2.0-fix-httplib-version.patch
	"

	PATCHES=(
		"${DISTDIR}/${PN}-0.2.0-fix-httplib-version.patch"
	)
fi

S="${WORKDIR}/${PN}"

LICENSE="GPL-3+"
SLOT="0"
IUSE="camera +cubeb discord llvm lto +opengl +qt6 room sdl test +usb web-applet web-service wifi"
REQUIRED_USE="
	!qt6? ( !camera !discord !web-applet )
	web-service? ( || ( qt6 room ) )
"
RESTRICT="!test? ( test )"

RDEPEND="
	app-arch/lz4
	app-arch/zstd
	dev-cpp/cpp-httplib:=[ssl]
	dev-libs/libfmt:=
	dev-libs/mcl
	dev-libs/openssl:=
	>=dev-libs/sirit-1.0.1
	dev-util/spirv-tools
	games-util/gamemode
	media-gfx/renderdoc
	media-libs/libsdl2[haptic,joystick,sound,video]
	media-libs/libva
	media-libs/opus
	media-video/ffmpeg
	net-libs/enet
	net-libs/mbedtls:3
	virtual/zlib:=

	camera? ( dev-qt/qtmultimedia:6 )
	cubeb? ( media-libs/cubeb )
	discord? (
		dev-libs/discord-rpc
	)
	qt6? (
		dev-libs/quazip[qt6(+)]
		dev-qt/qtbase:6[concurrent,dbus,gui,widgets]
		dev-qt/qtcharts:6
	)
	usb? ( dev-libs/libusb )
	web-applet? ( dev-qt/qtwebengine:6[widgets] )
	web-service? ( dev-cpp/cpp-httplib:=[ssl] )
	wifi? ( net-wireless/wireless-tools )
	llvm? ( llvm-core/llvm )
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

# [directory]=license
declare -A KEEP_BUNDLED=(
	# Generated or copied files for internal usage
	[bc_decoder]=MPL-2.0
	[cmake-modules]=LGPL-3+
	[demangle]=Apache-2.0-with-LLVM-exceptions
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

src_unpack() {
	if [[ "${PV}" == 9999 ]]; then
		git-r3_src_unpack

		# unpack src files
		unpack "nx-tzdb-${_TZDB_VER}.tar.gz"
	else
		default
	fi
}

src_prepare() {
	local s remove=()
	for s in externals/*; do
		[[ -f ${s} ]] && continue
		if ! has "${s#externals/}" "${!KEEP_BUNDLED[@]}"; then
			remove+=( "${s}" )
		fi
	done

	if (( ${#remove[@]} > 0 )); then
		einfo "removing sources: ${remove[*]}"
		rm -r "${remove[@]}" || die
	fi

	cmake_src_prepare
}

src_configure() {
	if [[ "${PV}" == 9999 ]]; then
		eden_ver="$(git rev-parse --short=10 HEAD)-9999"
	else
		eden_ver="v${PV/_/-}"
	fi

	if tc-is-gcc; then
		eden_comp_id="GCC $(gcc-fullversion)"
	elif tc-is-clang; then
		eden_comp_id="Clang $(clang-fullversion)"
	else
		eden_comp_id="$(tc-getcc)"
	fi

	local mycmakeargs=(
		-DCPMUTIL_FORCE_SYSTEM=yes
		-DTITLE_BAR_FORMAT_IDLE="Eden | ${eden_ver} | ${eden_comp_id}"
		-DYUZU_TZDB_PATH="${WORKDIR}/nx-tzdb-${_TZDB_VER}"
		-DUSE_FASTER_LINKER=no

		-DENABLE_LTO=$(usex lto)

		-DDYNARMIC_USE_LLVM=$(usex llvm)
		-DYUZU_DISABLE_LLVM=$(usex !llvm)

		-DBUILD_TESTING=$(usex test)
		-DENABLE_CUBEB=$(usex cubeb)
		-DENABLE_LIBUSB=$(usex usb)
		-DENABLE_OPENGL=$(usex opengl)
		-DENABLE_QT=$(usex qt6)
		-DENABLE_WEB_SERVICE=$(usex web-service)
		-DENABLE_WIFI_SCAN=$(usex wifi)
		-DUSE_DISCORD_PRESENCE=$(usex discord)
		-DYUZU_USE_QT_MULTIMEDIA=$(usex camera)
		-DYUZU_USE_QT_WEB_ENGINE=$(usex web-applet)

		-DYUZU_CMD=$(usex sdl)
		-DYUZU_ROOM=$(usex room)

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

pkg_postinst() {
	xdg_pkg_postinst

	optfeature_header "SDL requires HIDRAW access for many controller gyroscopes to work."
	optfeature "HIDRAW support" games-util/game-device-udev-rules
}
