# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Library for encoding and decoding .avif files"
HOMEPAGE="https://github.com/AOMediaCodec/libavif"
SRC_URI="https://github.com/AOMediaCodec/libavif/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
#IUSE="dav1d +libaom rav1e"
IUSE="dav1d"

#REQUIRED_USE="|| ( dav1d libaom )"
REQUIRED_USE="dav1d"

#unavailable dependencies
#	libaom? ( >=media-libs/libaom-1.1 )
#	rav1e? ( media-video/rav1e[capi] )
DEPEND="
	dav1d? ( media-libs/dav1d )
	media-libs/libpng
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
#		-DAVIF_CODEC_AOM=$(usex libaom ON OFF)
#		-DAVIF_CODEC_RAV1E=$(usex rav1e ON OFF)
	local mycmakeargs=(
		-DAVIF_CODEC_DAV1D=$(usex dav1d ON OFF)
		-DBUILD_SHARED_LIBS=ON
		-DAVIF_BUILD_APPS=ON
	)
	cmake_src_configure
}

pkg_postinst() {
#	if ! use libaom && ! use rav1e ; then
		ewarn "libaom and rav1e flags are not set,"
		ewarn "libavif will work in read-only mode."
		ewarn "Enable libaom or rav1e flag if you want to save .AVIF files."
#	fi

#instead of writing this below, use the := dependency

#	if use libaom ; then
#		elog "When you upgrade libaom in the future,"
#		elog " you may need to re-emerge libavif again"
#		elog " to ensure correct AVIF import/export functions."
#	fi

#	if use rav1e ; then
#		elog "When you upgrade rav1e in the future,"
#		elog " you may need to re-emerge libavif again"
#		elog " to ensure correct AVIF export function."
#	fi
}
