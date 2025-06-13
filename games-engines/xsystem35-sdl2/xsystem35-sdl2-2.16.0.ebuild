EAPI=8

inherit cmake

DESCRIPTION="Port of xsystem35, a free implementation of AliceSoft's System 3.x game engine."
HOMEPAGE="https://github.com/kichikuou/xsystem35-sdl2"
SRC_URI="https://github.com/kichikuou/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+man debug +portmidi +webp"

DEPEND="
	media-libs/libsdl2
	media-libs/sdl2-mixer
	media-libs/sdl2-ttf
	sys-libs/zlib
	webp? ( media-libs/libwebp )
	debug? ( dev-libs/cJSON )
	portmidi? ( media-libs/portmidi )
"
RDEPEND="${DEPEND}"
BDEPEND="
	sys-devel/gettext
	man? ( dev-ruby/asciidoctor )
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=$(usex debug Debug Release)
		-DENABLE_DEBUGGER=$(usex debug)
		-DENABLE_PORTMIDI=$(usex portmidi)
		-DENABLE_WEBP=$(usex webp)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	# Install additional documentation
	dodoc CHANGELOG.md game_compatibility.md
}
