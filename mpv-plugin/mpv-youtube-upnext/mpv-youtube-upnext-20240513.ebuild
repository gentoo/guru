# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
inherit mpv-plugin

COMMIT="6c0428285c44edbe3809eda8335ef4789da1bf19"
MY_P="${PN}-${COMMIT}"

DESCRIPTION="A userscript that allows you to play \"up next\"/recommended youtube videos"
HOMEPAGE="https://github.com/cvzi/mpv-youtube-upnext"
SRC_URI="https://github.com/cvzi/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
KEYWORDS="~amd64"

MPV_PLUGIN_FILES=( youtube-upnext.lua )
