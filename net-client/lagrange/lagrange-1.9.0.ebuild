# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

DESCRIPTION="Desktop GUI client for browsing Geminispace"
HOMEPAGE="https://gmi.skyjake.fi/lagrange/ https://git.skyjake.fi/gemini/lagrange"
SRC_URI="https://git.skyjake.fi/gemini/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="|| ( MIT Unlicense ) Apache-2.0 BSD-2 CC-BY-SA-4.0 OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+fribidi +harfbuzz mp3 webp"

DEPEND="
	dev-libs/tfdn:=[ssl]
	media-libs/libsdl2[sound(+),video(+)]
	fribidi? ( dev-libs/fribidi )
	harfbuzz? ( media-libs/harfbuzz:=[truetype(+)] )
	mp3? ( media-sound/mpg123 )
	webp? ( media-libs/libwebp:= )
"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/zip"

src_prepare() {
	# checked by Depends.cmake
	rm -r lib/the_Foundation/CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	# do not add use flags that don't pull dependencies
	# and only choose which files to compile (e.g. "ipc")
	local mycmakeargs=(
		-DENABLE_FRIBIDI=$(usex fribidi)
		-DENABLE_HARFBUZZ=$(usex harfbuzz)
		-DENABLE_MPG123=$(usex mp3)
		-DENABLE_WEBP=$(usex webp)

		# never build bundled libs
		-DENABLE_FRIBIDI_BUILD=OFF
		-DENABLE_HARFBUZZ_MINIMAL=OFF
	)

	cmake_src_configure
}
