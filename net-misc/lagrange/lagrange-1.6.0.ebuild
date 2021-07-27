# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake

DESCRIPTION="Desktop GUI client for browsing Geminispace"
HOMEPAGE="https://gmi.skyjake.fi/lagrange/
https://git.skyjake.fi/gemini/lagrange"
SRC_URI="https://git.skyjake.fi/gemini/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="|| ( MIT Unlicense ) Apache-2.0 BSD-2 OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_x86_sse4_1 +fribidi +harfbuzz +mp3"

DEPEND="
	dev-libs/libpcre:3
	dev-libs/libunistring
	dev-libs/openssl
	media-libs/libsdl2[sound(+),video(+)]
	sys-libs/zlib
	fribidi? ( dev-libs/fribidi )
	harfbuzz? ( media-libs/harfbuzz[truetype(+)] )
	mp3? ( media-sound/mpg123 )
"
RDEPEND="${DEPEND}"

src_configure() {
	# do not add use flags that don't pull dependencies
	# and only choose which files to compile (e.g. "ipc")
	local mycmakeargs=(
		-DENABLE_FRIBIDI=$(usex fribidi)
		-DENABLE_HARFBUZZ=$(usex harfbuzz)
		-DENABLE_MPG123=$(usex mp3)

		# lib/the_Foundation
		-DTFDN_ENABLE_WARN_ERROR=OFF
		-DTFDN_ENABLE_SSE41=$(usex cpu_flags_x86_sse4_1)
	)

	cmake_src_configure
}

pkg_postinst() {
	ewarn "Lagrange 1.6 introduces some breaking changes:"
	ewarn
	ewarn "- A new TOFU trust store will be created. The old one is kept around but ignored."
	ewarn "- App state serialization format has been updated. Downgrading to a previous release"
	ewarn "  will cause app state to be reset (e.g., tabs closed, navigation history cleared)."
}
