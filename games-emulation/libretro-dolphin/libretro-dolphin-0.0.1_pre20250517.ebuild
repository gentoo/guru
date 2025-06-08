# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This ebuild mirrors the setup done in `games-emulation/dolphin::gentoo`

EAPI=7

LIBRETRO_COMMIT_SHA="a09f78f735f0d2184f64ba5b134abe98ee99c65f"
LIBRETRO_REPO_NAME="libretro/dolphin"

inherit cmake libretro-core

DESCRIPTION="Dolphin libretro port"

LICENSE="GPL-2+ BSD BSD-2 LGPL-2.1+ MIT ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bluetooth egl +evdev log profile systemd test"
RESTRICT="!test? ( test )"

RDEPEND="
	app-arch/bzip2:=
	app-arch/xz-utils
	app-arch/zstd:=
	dev-libs/hidapi
	dev-libs/libfmt:=
	dev-libs/lzo:2
	dev-libs/pugixml
	dev-libs/xxhash
	games-emulation/libretro-info
	media-libs/cubeb
	<media-libs/libsfml-3.0:=
	net-libs/enet
	net-libs/mbedtls:0=
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXrandr
	virtual/libusb:1
	virtual/opengl
	bluetooth? ( net-wireless/bluez:= )
	evdev? (
		dev-libs/libevdev
		virtual/libudev
	)
	profile? ( dev-util/oprofile )
	systemd? ( sys-apps/systemd:0= )
"
DEPEND="
	${RDEPEND}
	egl? ( media-libs/libglvnd )
"
BDEPEND="
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/${P}-fix-for-fmt.patch"
)

# [directory]=license
declare -A KEEP_BUNDLED=(
	# Issues revealed at configure time
	#
	# Please keep this list in `CMakeLists.txt` order
	[Bochs_disasm]=LGPL-2.1+
	[cpp-optparse]=MIT
	[glslang]=BSD
	[imgui]=MIT
	[xxhash]=BSD-2
	[minizip]=ZLIB
	[libpng]=libpng2 # Intentionally static for Libretro
	[FreeSurround]=GPL-2+
	[soundtouch]=LGPL-2.1+
	[curl]=curl # Intentionally static for Libretro
	[gtest]=BSD

	# Issues revealed at compile time
	[Libretro]=MIT
	[picojson]=BSD-2 # Complains about exception handling being disabled
	[Vulkan]=Apache-2.0 # Relies on `VK_PRESENT_MODE_RANGE_SIZE_KHR`
)

add_bundled_licenses() {
	for license in "${KEEP_BUNDLED[@]}"; do
		LICENSE+=" ${license}"
	done
}
add_bundled_licenses

src_prepare() {
	cmake_src_prepare

	local s remove=()
	for s in Externals/*; do
		[[ -f ${s} ]] && continue
		if ! has "${s#Externals/}" "${!KEEP_BUNDLED[@]}"; then
			remove+=( "${s}" )
		fi
	done

	einfo "removing sources: ${remove[*]}"
	rm -r "${remove[@]}" || die
}

src_configure() {
	local mycmakeargs=(
		-DLIBRETRO=yes

		-DENABLE_BLUEZ=$(usex bluetooth)
		-DENABLE_EGL=$(usex egl)
		-DENABLE_EVDEV=$(usex evdev)
		-DENABLE_LTO=no # just adds -flto, user can do that via flags
		-DENABLE_NOGUI=no
		-DENABLE_TESTS=$(usex test)
		-DFASTLOG=$(usex log)
		-DOPROFILING=$(usex profile)

		# Use system libraries
		-DUSE_SHARED_ENET=yes

		# Undo cmake.eclass's defaults.
		# All Dolphin's libraries are private
		# and rely on circular dependency resolution.
		-DBUILD_SHARED_LIBS=no

		# Avoid warning spam around unset variables.
		-Wno-dev

		# System installed Git shouldn't affect non-live builds
		-DCMAKE_DISABLE_FIND_PACKAGE_Git=yes
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_test() {
	cmake_build unittests
}

src_install() {
	LIBRETRO_CORE_LIB_FILE="${BUILD_DIR}/${LIBRETRO_CORE_NAME}_libretro.so"
	libretro-core_src_install
}
