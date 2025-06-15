# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} luajit )

inherit lua

DESCRIPTION="Helper Utilities for a Multitude of Problems"
HOMEPAGE="http://hump.readthedocs.org/"
HOMEPAGE+=" https://github.com/vrld/hump/"
EGIT_COMMIT="08937cc0ecf72d1a964a8de6cd552c5e136bf0d4"
SRC_URI="https://github.com/vrld/hump/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc"
REQUIRED_USE="${LUA_REQUIRED_USE}"

DEPEND="${LUA_DEPS}"
RDEPEND="${DEPEND}"
BDEPEND="
	doc? (
		dev-python/sphinx
		dev-python/sphinx-rtd-theme
	)
"

src_compile() {
	use doc && emake -C docs/ man html
}

lua_src_install() {
	insinto $(lua_get_lmod_dir)/hump/
	doins *.lua
}

src_install() {
	lua_foreach_impl lua_src_install
	if use doc; then
		doman docs/_build/man/hump.1
		local HTML_DOCS=( docs/_build/html/. )
	fi
	einstalldocs
}
