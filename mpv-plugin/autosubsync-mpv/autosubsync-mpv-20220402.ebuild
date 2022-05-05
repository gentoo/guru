# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
inherit mpv-plugin

COMMIT="989e73fd25800d4722b9bb1105aac65f55fec035"
MY_P="${PN}-${COMMIT}"

DESCRIPTION="Automatic subtitle synchronization script for mpv media player"
HOMEPAGE="https://github.com/joaquintorres/autosubsync-mpv/"

SRC_URI="https://github.com/joaquintorres/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"

RDEPEND="
	media-video/ffsubsync
" # alass is supported but not in the gentoo tree

S="${WORKDIR}/${MY_P}"

MPV_PLUGIN_FILES=(
	autosubsync.lua
	main.lua
	menu.lua
	subtitle.lua
)
