# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake verify-sig xdg

DESCRIPTION="Desktop GUI client for browsing Geminispace"
HOMEPAGE="https://gmi.skyjake.fi/lagrange/ https://git.skyjake.fi/gemini/lagrange"
SRC_URI="https://git.skyjake.fi/gemini/${PN}/releases/download/v${PV}/${P}.tar.gz
	verify-sig? ( https://git.skyjake.fi/gemini/${PN}/releases/download/v${PV}/${P}.tar.gz.sig )"

LICENSE="|| ( MIT Unlicense ) Apache-2.0 BSD-2 CC-BY-SA-4.0 OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X +fribidi +harfbuzz mp3 ncurses webp"

RDEPEND="
	>=dev-libs/tfdn-1.4.0:=[ssl]
	X? ( x11-libs/libX11 )
	fribidi? ( dev-libs/fribidi )
	ncurses? ( >=dev-libs/sealcurses-2.0.18_pre20230206:= )
	!ncurses? (
		harfbuzz? ( media-libs/harfbuzz:=[truetype(+)] )
		media-libs/libsdl2[X?,sound(+),video(+)]
	)
	mp3? ( media-sound/mpg123 )
	webp? ( media-libs/libwebp:= )
"
DEPEND="${RDEPEND}
	X? ( x11-base/xorg-proto )
"
BDEPEND="
	app-arch/zip
	verify-sig? ( sec-keys/openpgp-keys-skyjake )
"

VERIFY_SIG_OPENPGP_KEY_PATH="${BROOT}/usr/share/openpgp-keys/skyjake.asc"

src_prepare() {
	# checked by Depends.cmake
	rm -r lib/the_Foundation/CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	# note: do not add use flags that don't pull dependencies
	# and only choose which files to compile (e.g. "ipc")
	local -a mycmakeargs=(
		-DENABLE_FRIBIDI=$(usex fribidi)
		-DENABLE_HARFBUZZ=$(usex harfbuzz)
		-DENABLE_TUI=$(usex ncurses)
		-DENABLE_MPG123=$(usex mp3)
		-DENABLE_WEBP=$(usex webp)
		-DENABLE_X11_XLIB=$(usex X)

		# never build bundled libs
		-DENABLE_FRIBIDI_BUILD=OFF
		-DENABLE_HARFBUZZ_MINIMAL=OFF
	)

	cmake_src_configure
}
