# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
inherit mpv-plugin

COMMIT="b71beb60eb71eb7df1266abfccd14c8cc451c643"
DESCRIPTION="A minimal script to skip sponsored segments of YouTube videos"
HOMEPAGE="https://codeberg.org/jouni/mpv_sponsorblock_minimal"
SRC_URI="https://codeberg.org/jouni/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
KEYWORDS="~amd64"

# TODO: package Lua-cURL
RDEPEND="net-misc/curl"

MPV_PLUGIN_FILES=(
	sponsorblock_minimal.lua
)
