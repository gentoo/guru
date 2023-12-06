# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="World's Leading Open Source JPEG 2000 Codec"
HOMEPAGE="https://github.com/GrokImageCompression/grok"
SRC_URI="https://github.com/GrokImageCompression/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="AGPL-3 BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	app-arch/zstd:=
	media-libs/libjpeg-turbo:=
	media-libs/libwebp:=
	media-libs/exiftool
"
RDEPEND="${DEPEND}"

src_configure() {
	# Not using -DGRK_BUILD_JPEG=OFF fails the build
	# (see https://github.com/GrokImageCompression/grok/issues/351)
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
		-DBUILD_SHARED_LIBS=ON
		-DGRK_BUILD_JPEG=OFF
	)
	cmake_src_configure
}
