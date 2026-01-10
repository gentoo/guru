# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="An open-source 3DS emulator project based on Citra"
HOMEPAGE="https://azahar-emu.org"
SRC_URI="
	https://github.com/azahar-emu/azahar/releases/download/${PV}/azahar-unified-source-${PV}.tar.xz -> ${P}.tar.xz
	https://github.com/azahar-emu/azahar/commit/1f483e1d335374482845d0325ac8b13af3162c53.patch ->
		${PN}-2123.3-fix-build-with-qt-6.10.patch
"

S="${WORKDIR}/azahar-unified-source-${PV}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cpu_flags_x86_sse4_2 test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/nlohmann_json
	dev-cpp/robin-map
	dev-libs/boost:=
	dev-libs/crypto++:=
	dev-libs/dynarmic
	dev-libs/inih
	dev-libs/libfmt:=
	dev-libs/microprofile
	dev-libs/nihstro
	dev-libs/openssl:=
	dev-libs/sirit
	dev-libs/teakra
	dev-qt/qtbase:6[concurrent,dbus,widgets]
	dev-qt/qtmultimedia:6
	dev-util/glslang
	media-libs/cubeb
	media-libs/faad2
	media-libs/libsdl2
	media-libs/libsoundtouch:=
	media-libs/openal
	media-video/ffmpeg
	net-libs/enet
	virtual/libusb
"
DEPEND="
	${RDEPEND}
	dev-util/spirv-headers
	dev-util/vulkan-headers
	media-libs/VulkanMemoryAllocator
	amd64? ( dev-libs/xbyak )
	arm64? ( dev-libs/oaknut )
"
BDEPEND="
	test? ( >=dev-cpp/catch-3:0 )
"

PATCHES=(
	"${DISTDIR}/${PN}-2123.3-fix-build-with-qt-6.10.patch"
	"${FILESDIR}/${PN}-2122.1-explicitly-require-the-tsl-robin-map-package.patch"
	"${FILESDIR}/${PN}-2122.1-import-some-of-the-symbols-from-spv.patch"
	"${FILESDIR}/${PN}-2122.1-link-to-Catch2-only-when-tests-are-enabled.patch"
	"${FILESDIR}/${PN}-2122.1-rename-AV_OPT_TYPE_CHANNEL_LAYOUT-to-AV_OPT_TYPE_CHL.patch"
	"${FILESDIR}/${PN}-2122.1-use-the-system-faad2-library.patch"
	"${FILESDIR}/${PN}-2122.1-use-the-system-teakra-library.patch"
	"${FILESDIR}/${PN}-2123-don-t-build-spirv-tools.patch"
	"${FILESDIR}/${PN}-2123-use-the-zstd_seekable.h-header-from-externals.patch"
	"${FILESDIR}/${PN}-2123.1-use-the-system-oaknut-library.patch"
	"${FILESDIR}/${PN}-2123.2-use-the-system-sirit-library.patch"
)

# [directory]=license
declare -A KEEP_BUNDLED=(
	# Generated or copied files for internal usage
	[cmake-modules]=Boost-1.0
	[dds-ktx]=BSD-2
	[gamemode]=BSD
	[glad]=MIT
	[open_source_archives]=GPL-2+

	# Reasons to keep are in `src_configure`
	[httplib]=MIT
	[lodepng]=ZLIB
	[zstd]="GPL-2"
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
		-DBUILD_SHARED_LIBS=no
		-DCITRA_USE_PRECOMPILED_HEADERS=no
		-DCITRA_WARNINGS_AS_ERRORS=no
		-DENABLE_WEB_SERVICE=no
		-DUSE_SYSTEM_LIBS=yes

		-DENABLE_SSE42=$(usex cpu_flags_x86_sse4_2)
		-DENABLE_TESTS=$(usex test)

		# Shared library is not supported
		-DDISABLE_SYSTEM_CPP_HTTPLIB=yes

		# Lodepng is designed to be bundled
		-DDISABLE_SYSTEM_LODEPNG=yes

		# Upstream depends on `zstd/contrib/seekable_format/zstd_seekable.h`
		-DDISABLE_SYSTEM_ZSTD=yes

		-Wno-dev
	)

	cmake_src_configure
}
