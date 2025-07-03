# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..3} luajit )

inherit lua

DESCRIPTION="Pure Lua implementation of the wcwidth() function"
HOMEPAGE="https://github.com/aperezdc/lua-wcwidth/"
SRC_URI="https://github.com/aperezdc/lua-wcwidth/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"

SLOT="0"

KEYWORDS="~amd64"

IUSE="test"

REQUIRED_USE="${LUA_REQUIRED_USE}"

DEPEND="${LUA_DEPS}"
RDEPEND="${DEPEND}"
BDEPEND="test? ( dev-lua/dromozoa-utf8[${LUA_USEDEP}] )"

lua_enable_tests busted

lua_src_install() {
	insinto "$(lua_get_lmod_dir)"
	doins wcwidth.lua
	insinto "$(lua_get_lmod_dir)/${PN}"
	doins wcwidth/*.lua
}

src_install() {
	lua_foreach_impl lua_src_install
	dodoc README.md CHANGELOG.md
}
