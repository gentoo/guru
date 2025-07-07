# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..3} luajit )

inherit lua

DESCRIPTION="Basic UTF8-handling functions for Lua"
HOMEPAGE="https://github.com/blitmap/lua-utf8-simple"
EGIT_COMMIT="7ef030750d8e408ac5d724aefab2ec8769731005"
SRC_URI="https://github.com/blitmap/lua-utf8-simple/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${LUA_REQUIRED_USE}"

DEPEND="${LUA_DEPS}"
RDEPEND="${DEPEND}"

lua_src_test() {
	${ELUA} shitty_testcases.lua || die
}

src_test() {
	lua_foreach_impl lua_src_test
}

lua_src_install() {
	insinto $(lua_get_lmod_dir)
	doins utf8_simple.lua
}

src_install() {
	lua_foreach_impl lua_src_install
	dodoc README.md
}
