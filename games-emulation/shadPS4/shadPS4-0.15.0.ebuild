# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="PlayStation 4 emulator written in C++"
HOMEPAGE="https://shadps4.net"
SRC_URI="https://codeberg.org/ceres-sees-all/guru-distfiles/releases/download/${P}-submodules.tar.xz/${P}-submodules.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="discord test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-cpp/cli11
	dev-cpp/magic_enum
	dev-cpp/nlohmann_json
	dev-cpp/robin-map
	dev-cpp/toml11
	dev-libs/boost
	dev-libs/libfmt
	dev-libs/half
	dev-libs/pugixml
	dev-libs/stb
	dev-libs/xbyak
	dev-libs/xxhash
	media-libs/imgui
	media-libs/libsdl3
	media-libs/libpng
	media-libs/openal
	media-libs/sdl3-mixer
	media-libs/vulkan-layers
	media-gfx/renderdoc
	media-video/ffmpeg
	media-sound/sndio
	virtual/jack
	virtual/zlib
	test? ( dev-cpp/gtest )
"

RDEPEND="${DEPEND}"

src_prepare() {
	eapply "${FILESDIR}/${P}-SDL3-rename.patch"
	eapply "${FILESDIR}/${P}-cmake-4.patch"
	eapply "${FILESDIR}/${P}-executable-stack.patch"
	mv src/core/libraries/fiber/fiber_context.s src/core/libraries/fiber/fiber_context.S || die
	cmake_src_prepare
}

src_configure() {
	filter-lto
	append-flags -fno-strict-aliasing

	local mycmakeargs=(
		-DENABLE_DISCORD_RPC="$(usex discord ON OFF)"
		-DENABLE_UPDATER=OFF
		-DENABLE_TESTS="$(usex test ON OFF)"
	)
	cmake_src_configure
}
