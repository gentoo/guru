# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
inherit mpv-plugin

COMMIT="35115355bd339681f97d067538356c29e5b14afa"
MY_P="${PN}-${COMMIT}"

DESCRIPTION="Fully automatic subtitle downloading for the MPV media player"
HOMEPAGE="https://github.com/davidde/mpv-autosub"
SRC_URI="https://github.com/davidde/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
KEYWORDS="~amd64"

RDEPEND="
	media-video/subliminal
"

MPV_PLUGIN_FILES=( autosub.lua )
