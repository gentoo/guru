# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# sirocco dependency does not yet support newer Lua implementations
LUA_COMPAT=( lua5-1 luajit )

inherit lua

DESCRIPTION="A Lua REPL and debugger "
HOMEPAGE="https://github.com/giann/croissant"
EGIT_COMMIT="dc633a0ac3b5bcab9b72b660e926af80944125b3"
SRC_URI="https://github.com/giann/croissant/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="examples"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="
	dev-lua/lua-term[${LUA_USEDEP}]
	dev-lua/sirocco[${LUA_USEDEP}]
	dev-lua/hump[${LUA_USEDEP}]
	dev-lua/lpeg[${LUA_USEDEP}]
	dev-lua/lua-argparse[${LUA_USEDEP}]
	dev-lua/compat53[${LUA_USEDEP}]
	${LUA_DEPS}
"

DEPEND="${RDEPEND}"

lua_src_install() {
	insinto "$(lua_get_lmod_dir)/${PN}"
	doins croissant/*.lua
}

src_install() {
	lua_foreach_impl lua_src_install
	dobin bin/croissant
	dodoc README.md
	if use examples; then
		docinto examples
		dodoc debugtest.lua
	fi
}
