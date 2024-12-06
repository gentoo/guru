# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} luajit )

inherit edo lua toolchain-funcs

DESCRIPTION="Lua bindings to libpsl"
HOMEPAGE="https://github.com/daurnimator/lua-psl"
EGIT_COMMIT="25f9c32336aea171ea1bdb715d755bc25b18887a"
SRC_URI="https://github.com/daurnimator/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc"
REQUIRED_USE="${LUA_REQUIRED_USE}"

DEPEND="
	${LUA_DEPS}
	net-libs/libpsl
"
RDEPEND="${DEPEND}"
BDEPEND="doc? ( virtual/pandoc )"

lua_enable_tests busted "${BUILD_DIR}"

src_prepare() {
	default
	lua_copy_sources
}

lua_src_compile() {
	cd "${BUILD_DIR}" || die
	edo $(tc-getCC) -shared -fPIC \
	${CPPFLAGS} \
	${CFLAGS} $(lua_get_CFLAGS) \
	${LDFLAGS} $(lua_get_LIBS) \
	${SOFLAGS} \
	-o psl.so psl/psl.c -lpsl
}

src_compile() {
	use doc && emake -C doc lua-psl.html
	lua_foreach_impl lua_src_compile
}

lua_src_test() {
	cd "${BUILD_DIR}" || die
	busted --lua="${ELUA}" --output="plainTerminal" "${BUILD_DIR}" || die "Tests fail with ${ELUA}"
}

src_test() {
	lua_foreach_impl lua_src_test
}

lua_src_install() {
	exeinto $(lua_get_cmod_dir)/
	doexe "${BUILD_DIR}"/psl.so
}

src_install() {
	lua_foreach_impl lua_src_install
	use doc && local HTML_DOCS=( doc/lua-psl.html )
	doman "${FILESDIR}"/lua-psl.3
	einstalldocs
}
