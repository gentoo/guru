# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-4 )

inherit git-r3 lua-single

DESCRIPTION="Wikimedia Commons export plugin for Darktable"
HOMEPAGE="https://github.com/trougnouf/dtMediaWiki"
EGIT_REPO_URI="https://github.com/trougnouf/dtMediaWiki"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	$LUA_DEPS
	media-gfx/darktable[lua]
	$(lua_gen_cond_dep '
		dev-lua/luasec[${LUA_USEDEP}]
		dev-lua/luajson[${LUA_USEDEP}]
		dev-lua/multipart-post[${LUA_USEDEP}]
	')
"

src_install() {
	insinto /usr/share/darktable/lua/contrib/dtMediaWiki
	doins -r *
}

pkg_postinst() {
	einfo "To enable: `cat "$FILESDIR"/enable.sh`"
	einfo "and go to Darktable preferences (gear ico on the top) -> at the bottom left click 'Lua options'"
	einfo "to enter username and password"
}
