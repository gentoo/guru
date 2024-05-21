# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Wikimedia Commons export plugin for Darktable"
HOMEPAGE="https://github.com/trougnouf/dtMediaWiki"
EGIT_REPO_URI="https://github.com/trougnouf/dtMediaWiki"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	media-gfx/darktable[lua]
	dev-lua/luasec[lua_targets_lua5-4]
	dev-lua/luajson[lua_targets_lua5-4]
	dev-lua/multipart-post[lua_targets_lua5-4]
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
