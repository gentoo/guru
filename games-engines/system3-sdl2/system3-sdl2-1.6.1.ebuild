EAPI=8

inherit cmake

YMFM_COMMIT="10c72f79bea3e0ab66af32d4295519aa17e6ea0f"  # Check if this needs updating on xsystem35 updates

DESCRIPTION="SDL2 port of AliceSoft's System3 for Win32 by Takeda Toshiya."
HOMEPAGE="https://github.com/kichikuou/system3-sdl2"
SRC_URI="
	https://github.com/kichikuou/system3-sdl2/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/aaronsgiles/ymfm/archive/${YMFM_COMMIT}.tar.gz -> ymfm-${YMFM_COMMIT}.tar.gz
"

LICENSE="GPL-2"
# ymfm submodule license
LICENSE+=" BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="rtmidi debug"

DEPEND="
	media-libs/libsdl2
	media-libs/sdl2-mixer
	media-libs/sdl2-ttf
	rtmidi? ( media-libs/rtmidi )"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_unpack() {
	default

	rmdir "${S}"/deps/ymfm || die
	mv "${WORKDIR}"/ymfm-${YMFM_COMMIT}/ "${S}"/deps/ymfm || die
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=$(usex debug Debug Release)
		-DENABLE_DEBUGGER=$(usex debug)
		-DBUILD_SHARED_LIBS=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	# Install additional documentation
	dodoc CHANGELOG.md game_compatibility.md
}
