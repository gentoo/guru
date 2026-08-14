# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Convert SUP graphic subtitles to text-based SRT format"
HOMEPAGE="https://github.com/retrontology/sup2srt"
SRC_URI="https://github.com/retrontology/sup2srt/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-text/tesseract
	media-libs/leptonica
	media-libs/tiff[cxx]
	media-video/ffmpeg:=
"
BDEPEND="
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/${PN}-1.0.6-build-the-pgs-library-statically.patch"
)
