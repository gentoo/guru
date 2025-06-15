# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Currently, lax optional argument introduced in Lua 5.4 is not supported,
# so it is not compatible with Lua 5.4 or later
LUA_COMPAT=( lua5-3 )

inherit lua

DESCRIPTION="Lua 5.3 compatible pure-Lua UTF-8 implementation"
HOMEPAGE="https://dromozoa.github.io/dromozoa-utf8/"
HOMEPAGE+=" https://github.com/dromozoa/dromozoa-utf8"
SRC_URI="https://github.com/dromozoa/dromozoa-utf8/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${LUA_DEPS}"
DEPEND="${RDEPEND}"

lua_src_test() {
	# inside test.sh lua command is called,
	# so each implementation should be tested separately
	./test.sh || die "Tests failed for ${LUA}"
}

src_test() {
	lua_foreach_impl lua_src_test
}

lua_src_install() {
	insinto "$(lua_get_lmod_dir)"
	doins -r dromozoa/
}

src_install() {
	lua_foreach_impl lua_src_install
	dobin dromozoa-markdown-table
	HTML_DOCS=( docs/index.html )
	# Install only the latest documentation
	DOCS+=( docs/16.0.0/ )
	einstalldocs
}
