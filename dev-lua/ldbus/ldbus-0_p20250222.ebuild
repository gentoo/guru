# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} luajit )
inherit lua toolchain-funcs

DESCRIPTION="Lua library to access dbus."
HOMEPAGE="https://github.com/daurnimator/ldbus"
EGIT_COMMIT="2571a9ba15d03bc40ac2e406f42ef14b322e1c01"
SRC_URI="https://github.com/daurnimator/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="
	${LUA_DEPS}
	dev-lua/compat53[${LUA_USEDEP}]
	sys-apps/dbus
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/${PN}-0-rm_vendor_compat53.patch )

DOCS=( README.md example.lua )

src_prepare() {
	default
	rm -r vendor || die
	lua_copy_sources
}

lua_src_compile() {
	local myemakeargs=(
		CC=$(tc-getCC)
		LUA_PKGNAME=${ELUA}
		PKG_CONFIG=$(tc-getPKG_CONFIG)
	)

	emake "${myemakeargs[@]}" -C "${BUILD_DIR}"/src
}

src_compile() {
	lua_foreach_impl lua_src_compile
}

lua_src_install() {
	exeinto $(lua_get_cmod_dir)
	doexe "${BUILD_DIR}"/src/${PN}.so
}

src_install() {
	lua_foreach_impl lua_src_install
	einstalldocs
}
