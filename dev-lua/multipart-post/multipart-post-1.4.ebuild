# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} luajit )

inherit lua

DESCRIPTION="HTTP Multipart Post helper that does just that."
HOMEPAGE="https://github.com/catwell/lua-multipart-post"
SRC_URI="https://github.com/catwell/lua-$PN/archive/refs/tags/v$PV.tar.gz -> lua-${P}.tar.gz"
S="$WORKDIR/lua-$P"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="dev-lua/luasocket[${LUA_USEDEP}]"

# Require cwtes, which is not in the tree yet
RESTRICT="test"

DOCS=( README.md )

lua_src_install() {
	insinto "$(lua_get_lmod_dir)"
	doins multipart-post.lua
}

src_install() {
	lua_foreach_impl lua_src_install

	einstalldocs
}
