# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# No lua5.2+ in mpv
LUA_COMPAT=( lua5-1 luajit )

inherit lua-single

DESCRIPTION="Simple mpv script to skip sponsored segments of YouTube videos"
HOMEPAGE="https://codeberg.org/jouni/mpv_sponsorblock_minimal"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

REQUIRED_USE="${LUA_REQUIRED_USE}"
DEPEND="${LUA_DEPS}"
RDEPEND="
	${DEPEND}
	$(lua_gen_cond_dep '
		media-video/mpv[${LUA_USEDEP}]
	')
	net-misc/curl
"

src_install() {
	insinto "/usr/share/mpv/lua/sponsorblock-minimal.lua"
	doins sponsorblock_minimal.lua
}
