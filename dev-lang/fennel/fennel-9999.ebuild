# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..4} luajit )

inherit lua-single

DESCRIPTION="Fennel is a lisp that compiles to Lua"
HOMEPAGE="https://fennel-lang.org/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~technomancy/fennel"
else
	SRC_URI="https://git.sr.ht/~technomancy/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
REQUIRED_USE="${LUA_REQUIRED_USE}"

BDEPEND="${LUA_DEPS}"
RDEPEND="${BDEPEND}"
DEPEND="${RDEPEND}"

pkg_setup() {
	lua-single_pkg_setup
}

src_compile() {
	emake LUA_VERSION="$(lua_get_version)" \
		  LUA_LIB_DIR="${D}/$(lua_get_lmod_dir)" \
		  PREFIX="${D}/usr"
}

src_install() {
	emake LUA_VERSION="$(lua_get_version)" \
		  LUA_LIB_DIR="${D}/$(lua_get_lmod_dir)" \
		  PREFIX="${D}/usr" install
	doman "${PN}.1"
	dodoc *.md
}
