# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..3} luajit )

inherit lua

DESCRIPTION="Lua library for creating a terminal UI "
HOMEPAGE="https://github.com/daurnimator/lua-tui"
EGIT_COMMIT="9e854fc22074d73a26fbf25cf24690c60b042b11"
SRC_URI="https://github.com/daurnimator/lua-tui/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="examples"
REQUIRED_USE="${LUA_REQUIRED_USE}"

DEPEND="${LUA_DEPS}"
RDEPEND="${DEPEND}"

lua_enable_tests busted

lua_src_install() {
	insinto "$(lua_get_lmod_dir)"
	doins -r tui
}

src_install() {
	lua_foreach_impl lua_src_install
	dodoc README.md BUGS.md
	if use examples; then
		docinto examples
		dodoc examples/*.lua
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
