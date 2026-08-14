# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Use almost any camera as a webcam—DSLRs, mirrorless, camcorders, and more"
HOMEPAGE="https://github.com/cowtoolz/webcamize"
SRC_URI="https://github.com/cowtoolz/webcamize/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-video/v4l2loopback
	media-video/ffmpeg
	media-libs/libgphoto2
"

src_compile() {
	emake
}

src_install() {
	emake \
	DESTDIR="${D}" \
	PREFIX="/usr" \
	BINDIR="bin" \
	install
	dodoc readme.md
}
