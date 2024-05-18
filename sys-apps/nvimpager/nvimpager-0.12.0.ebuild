# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..2} luajit )

inherit lua-single

DESCRIPTION="Use nvim as a pager to view manpages, diff, etc with nvim's syntax highlighting."
HOMEPAGE="https://github.com/lucc/nvimpager"
SRC_URI="https://github.com/lucc/nvimpager/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
REQUIRED_USE="test? ( ${LUA_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

DEPEND="
	>=app-editors/neovim-0.9.0[-nvimpager]
	app-shells/bash
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-text/scdoc
	test? ( $(lua_gen_cond_dep 'dev-lua/busted[${LUA_USEDEP}]') )
"

src_compile() { :; }

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
