# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A Beautiful Gemini Client"
HOMEPAGE="https://gmi.skyjake.fi/lagrange/"
if [ "${PV}" == "9999" ]; then
	inherit git-r3

	EGIT_REPO_URI="https://git.skyjake.fi/gemini/${PN}.git"
else
	SRC_URI="https://git.skyjake.fi/skyjake/${PN}/releases/download/v${PV}/${PN}-${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="BSD-2"
SLOT=0
IUSE="mpg123"

RDEPEND="
	>=dev-libs/openssl-1.1.1
	media-libs/libsdl2
	dev-libs/libpcre
	sys-libs/zlib
	dev-libs/libunistring
	mpg123? ( media-sound/mpg123 )
"

src_configure() {
	if use mpg123; then
		mycmakeargs+=("-DENABLE_MPG123")
	fi
	mycmakeargs+=("-DCMAKE_BUILD_TYPE=Release")
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_install() {
	cmake_src_install
}
