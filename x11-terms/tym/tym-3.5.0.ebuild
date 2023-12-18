# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-3 luajit )
inherit lua-single xdg

if [[ ${PV} == 9999 ]]; then
	inherit git-r3 autotools
	EGIT_REPO_URI="https://github.com/endaaman/tym"
else
	SRC_URI="https://github.com/endaaman/tym/releases/download/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Lua-configurable terminal emulator"
HOMEPAGE="https://github.com/endaaman/tym"

LICENSE="MIT"
SLOT="0"

REQUIRED_USE="${LUA_REQUIRED_USE}"

DEPEND="
	${LUA_DEPS}
	x11-libs/gtk+:3
	x11-libs/vte
"
RDEPEND="${DEPEND}"

src_configure() {
	if [[ ${PV} == 9999 ]]; then
		eautoreconf
	fi
	econf --enable-luajit=$(usex lua_single_target_luajit yes no)
}
