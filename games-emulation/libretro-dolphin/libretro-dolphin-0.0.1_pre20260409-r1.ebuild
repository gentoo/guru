# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This ebuild mirrors the setup done in `games-emulation/dolphin::gentoo`

EAPI=8

LIBRETRO_COMMIT_SHA="0cd3bb89c29535db9b7552fc86871867ccf5b471"
LIBRETRO_REPO_NAME="libretro/dolphin"

inherit cmake
# TODO no EAPI-8 #966155, copy in relevant code
# inherit libretro-core

DESCRIPTION="Dolphin libretro port"
HOMEPAGE="https://github.com/libretro/dolphin"

CPPIPC_COMMIT="ab4e5bd18e554aaa4503a0c6f6174d9bbfb11b42" # v1.4.1
CPPOPTPARSE_COMMIT="2265d647232249a53a03b411099863ceca35f0d3"
WATCHER_COMMIT="06f84a1314be18f5e697ebbf28c0fab2d17c9c39" #v0.14.5
SRC_URI="
	https://github.com/libretro/dolphin/archive/${LIBRETRO_COMMIT_SHA}.tar.gz -> ${P}.tar.gz
	https://github.com/mutouyun/cpp-ipc/archive/${CPPIPC_COMMIT}.tar.gz
		-> cpp-ipc-${CPPIPC_COMMIT}.tar.gz
	https://github.com/weisslj/cpp-optparse/archive/${CPPOPTPARSE_COMMIT}.tar.gz
		-> cpp-optparse-${CPPOPTPARSE_COMMIT}.tar.gz
	https://github.com/e-dant/watcher/archive/${WATCHER_COMMIT}.tar.gz
		-> watcher-${WATCHER_COMMIT}.tar.gz
"
S="${WORKDIR}/dolphin-${LIBRETRO_COMMIT_SHA}"

LICENSE="GPL-2+ BSD BSD-2 LGPL-2.1+ MIT ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bluetooth egl +evdev log test"
RESTRICT="!test? ( test )"

RDEPEND="
	app-arch/bzip2:=
	app-arch/lz4:=
	app-arch/xz-utils
	app-arch/zstd:=
	dev-cpp/tinygltf
	dev-libs/hidapi
	dev-libs/libfmt:=
	dev-libs/lzo:2
	dev-libs/pugixml
	dev-libs/xxhash
	dev-util/glslang:=
	games-emulation/libretro-info
	media-libs/cubeb
	>=media-libs/imgui-1.92
	media-libs/implot:0/0.17
	>=media-libs/libsfml-3.0:=
	media-libs/libspng
	net-libs/enet
	net-libs/mbedtls:0=
	net-misc/curl
	sys-libs/minizip-ng:=
	virtual/libusb:1
	virtual/opengl
	virtual/zlib:=
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXrandr
	bluetooth? ( net-wireless/bluez:= )
	evdev? (
		dev-libs/libevdev
		virtual/libudev
	)
"
DEPEND="
	${RDEPEND}
	dev-util/vulkan-headers
	media-libs/VulkanMemoryAllocator
	egl? ( media-libs/libglvnd )
"
BDEPEND="
	virtual/pkgconfig
	test? ( dev-cpp/gtest )
"

PATCHES=(
	"${FILESDIR}/${PN}-0.0.1_pre20260409-allow-running-tests.patch"
	"${FILESDIR}/${PN}-0.0.1_pre20260409-use-more-system-libraries.patch"
)

# [directory]=license
declare -A KEEP_BUNDLED=(
	# Please keep this list in `CMakeLists.txt` order
	[Bochs_disasm]=LGPL-2.1+
	[cpp-optparse]=MIT
	[FreeSurround]=GPL-2+
	[picojson]=BSD-2
	[expr]=MIT
	[FatFs]=FatFs
	[watcher]=MIT
	[cpp-ipc]=MIT
	[Libretro]=MIT
)

add_bundled_licenses() {
	for license in "${KEEP_BUNDLED[@]}"; do
		LICENSE+=" ${license}"
	done
}
add_bundled_licenses

src_prepare() {
	mv -T "${WORKDIR}/cpp-ipc-${CPPIPC_COMMIT}" "Externals/cpp-ipc/cpp-ipc" || die
	mv -T "${WORKDIR}/cpp-optparse-${CPPOPTPARSE_COMMIT}" "Externals/cpp-optparse/cpp-optparse" || die
	mv -T "${WORKDIR}/watcher-${WATCHER_COMMIT}" "Externals/watcher/watcher" || die

	# Avoid QA notices about CMake compatibility
	rm -rf "Externals/cpp-ipc/cpp-ipc/3rdparty/gtest" || die

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
	# TODO libretro-core.eclass does not support EAPI-8 #966155

	# LIBRETRO_CORE_LIB_FILE="${BUILD_DIR}/${LIBRETRO_CORE_NAME}_libretro.so"
	# libretro-core_src_install

	# libretro-core_src_install from libretro-core.eclass
	local LIBRETRO_CORE_NAME=${PN#libretro-}
	LIBRETRO_CORE_NAME=${LIBRETRO_CORE_NAME//-/_}

	local LIBRETRO_CORE_LIB_FILE="${BUILD_DIR}/${LIBRETRO_CORE_NAME}_libretro.so"

	# Absolute path of the directory containing Libretro shared libraries.
	local libretro_lib_dir="/usr/$(get_libdir)/libretro"
	# If this core's shared library exists, install that.
	if [[ -f "${LIBRETRO_CORE_LIB_FILE}" ]]; then
		exeinto "${libretro_lib_dir}"
		doexe "${LIBRETRO_CORE_LIB_FILE}"
	else
		# Basename of this library.
		local lib_basename="${LIBRETRO_CORE_LIB_FILE##*/}"

		# Absolute path to which this library was installed.
		local lib_file_target="${ED}${libretro_lib_dir}/${lib_basename}"

		# If this library was *NOT* installed, fail.
		[[ -f "${lib_file_target}" ]] ||
			die "Libretro core shared library \"${lib_file_target}\" not installed."
	fi
}
