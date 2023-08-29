# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
inherit distutils-r1

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/mps-youtube/yewtube.git"
	inherit git-r3
else
	SRC_URI="https://github.com/mps-youtube/${PN}/archive/refs/tags/v${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Terminal-based YouTube player and downloader"
HOMEPAGE="https://github.com/mps-youtube/yewtube https://pypi.org/project/yewtube/"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="${DEPEND}
 	media-video/ffmpeg
	dev-python/requests
	dev-python/pyperclip
	net-misc/yt-dlp
	dev-python/youtube-search-python
	dev-python/pylast
	dev-python/pip
	|| ( media-video/mplayer media-video/mpv )"

src_compile() {
	distutils-r1_src_compile --build-dir "${WORKDIR}/${P}"
}

src_install() {
	distutils-r1_src_install --build-dir "${WORKDIR}/${P}"
}