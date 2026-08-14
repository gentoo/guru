# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
inherit mpv-plugin

COMMIT="8f4b186d6ea46e6fe0e5e94a53dda2f50dceb576"
DESCRIPTION="A minimal script to skip sponsored segments of YouTube videos"
HOMEPAGE="https://codeberg.org/jouni/mpv_sponsorblock_minimal"
SRC_URI="https://codeberg.org/jouni/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
KEYWORDS="~amd64"

RDEPEND="net-misc/curl"

MPV_PLUGIN_FILES=( sponsorblock_minimal.lua )
DOCS=( README.md )
