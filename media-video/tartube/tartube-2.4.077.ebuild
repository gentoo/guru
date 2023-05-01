# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 xdg

DESCRIPTION="A GUI front-end for youtube-dl"
HOMEPAGE="https://github.com/axcore/tartube"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/axcore/tartube.git"
else
	SRC_URI="https://github.com/axcore/tartube/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+atomicparsley"

RDEPEND="
	dev-python/feedparser[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/playsound[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	x11-themes/adwaita-icon-theme
	|| (
		net-misc/youtube-dl[${PYTHON_USEDEP}]
		net-misc/yt-dlp[${PYTHON_USEDEP}]
	)
	atomicparsley? (
		media-video/atomicparsley
	)
"

src_prepare() {
	export TARTUBE_PKG_STRICT=1
	sed '/Version/d' -i pack/tartube.desktop
	distutils-r1_src_prepare
}
