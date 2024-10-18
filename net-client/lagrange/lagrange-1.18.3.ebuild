# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic verify-sig xdg

DESCRIPTION="Desktop GUI client for browsing Geminispace"
HOMEPAGE="https://gmi.skyjake.fi/lagrange/ https://git.skyjake.fi/gemini/lagrange"
SRC_URI="https://git.skyjake.fi/gemini/${PN}/releases/download/v${PV}/${P}.tar.gz
	verify-sig? ( https://git.skyjake.fi/gemini/${PN}/releases/download/v${PV}/${P}.tar.gz.sig )"

LICENSE="|| ( MIT Unlicense ) Apache-2.0 BSD-2 CC-BY-SA-4.0 OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X +bidi debug +gui +harfbuzz mp3 ncurses opus webp"
REQUIRED_USE="|| ( gui ncurses )"

RDEPEND="
	>=dev-libs/tfdn-1.9.0:=[ssl]
	media-libs/libsdl2[X?,sound(+),video(+)]
	gui? (
		X? ( x11-libs/libX11 )
		bidi? ( dev-libs/fribidi )
		harfbuzz? ( media-libs/harfbuzz:=[truetype(+)] )
		mp3? ( media-sound/mpg123-base )
		opus? ( media-libs/opusfile )
		webp? ( media-libs/libwebp:= )
	)
	ncurses? ( >=dev-libs/sealcurses-2.0.18_pre20230206:= )
"
DEPEND="${RDEPEND}
	gui? (
		X? ( x11-base/xorg-proto )
	)
"
BDEPEND="
	app-arch/zip
	virtual/pkgconfig
	verify-sig? ( sec-keys/openpgp-keys-skyjake )
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/skyjake.asc"

src_prepare() {
	# remove libs that can be accidentally built by Depends.cmake
	mv lib never-build-bundled-libs || die

	cmake_src_prepare
}

src_configure() {
	local -a mycmakeargs=(
		-DENABLE_GUI=$(usex gui)
		-DENABLE_TUI=$(usex ncurses)

		# note: do not add use flags that don't pull dependencies
		# and only choose which files to compile (e.g. "ipc")
		-DENABLE_FRIBIDI=$(usex bidi)
		-DENABLE_HARFBUZZ=$(usex harfbuzz)
		-DENABLE_MPG123=$(usex mp3)
		-DENABLE_OPUS=$(usex opus)
		-DENABLE_WEBP=$(usex webp)
		-DENABLE_X11_XLIB=$(usex X)

		# never build bundled libs
		-DENABLE_FRIBIDI_BUILD=OFF
		-DENABLE_HARFBUZZ_MINIMAL=OFF
	)

	append-cppflags $(usex debug "-UNDEBUG" "-DNDEBUG")
	cmake_src_configure
}
