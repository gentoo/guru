# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg

DESCRIPTION="Desktop GUI client for browsing Geminispace"
HOMEPAGE="https://gmi.skyjake.fi/lagrange/
https://git.skyjake.fi/gemini/lagrange"
SRC_URI="https://git.skyjake.fi/gemini/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="|| ( MIT Unlicense ) Apache-2.0 BSD-2 OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_x86_sse4_1 +mp3"

DEPEND="
	dev-libs/libpcre
	dev-libs/libunistring
	dev-libs/openssl
	media-libs/libsdl2
	sys-libs/zlib
	mp3? ( media-sound/mpg123 )
"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_MPG123=$(usex mp3)

		# lib/the_Foundation
		-DTFDN_ENABLE_WARN_ERROR=OFF
		-DTFDN_ENABLE_SSE41=$(usex cpu_flags_x86_sse4_1)
	)

	cmake_src_configure
}
