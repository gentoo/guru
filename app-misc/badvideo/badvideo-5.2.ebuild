# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Ruin your videos in SECONDS!"
HOMEPAGE="https://github.com/kernaltrap8/badvideo"
SRC_URI="https://github.com/kernaltrap8/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-video/ffmpeg[opus,x264]
"
DEPEND="${RDEPEND}"

src_install() {
	newbin "${S}"/src/badvideo.sh badvideo
}
