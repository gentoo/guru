# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Ruin your videos in SECONDS!"
HOMEPAGE="https://github.com/kernaltrap8/badvideo"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kernaltrap8/badvideo"
	S="${WORKDIR}/${PN}-9999"
fi

LICENSE="BSD"
SLOT="0"

RDEPEND="
	media-video/ffmpeg[opus,x264]
"
DEPEND="${RDEPEND}"

src_install() {
	newbin ${S}/src/badvideo.sh badvideo
}
