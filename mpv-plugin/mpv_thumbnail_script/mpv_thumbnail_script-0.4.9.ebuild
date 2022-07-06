# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MPV_REQ_USE="lua"
PYTHON_COMPAT=( python3_{8..10} )
inherit mpv-plugin python-any-r1

DESCRIPTION="A Lua script to show preview thumbnails in mpv's OSC seekbar"
HOMEPAGE="https://github.com/marzzzello/mpv_thumbnail_script"

SRC_URI="https://github.com/marzzzello/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64"

BDEPEND="
	${PYTHON_DEPS}
"

MPV_PLUGIN_FILES=(
	${PN}_client_osc.lua
	${PN}_server.lua
)

src_compile() {
	${EPYTHON} concat_files.py -r "cat_osc.json" || die
	${EPYTHON} concat_files.py -r "cat_server.json" || die
}
