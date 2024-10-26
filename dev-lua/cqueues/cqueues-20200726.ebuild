# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} luajit )
MY_P="${PN}-rel-${PV}"

inherit lua toolchain-funcs

DESCRIPTION="Stackable Continuation Queues"
HOMEPAGE="http://25thandclement.com/~william/projects/cqueues.html https://github.com/wahern/cqueues"
SRC_URI="https://github.com/wahern/${PN}/archive/rel-${PV}.tar.gz -> ${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

REQUIRED_USE="${LUA_REQUIRED_USE}"

# tests with starttls are buggy
RESTRICT="test"

DEPEND="
	${LUA_DEPS}
	dev-libs/openssl:0=
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( "doc/." )

# Thanks to dev-lua/luaossl for workarounds

src_prepare() {
	default

	sed \
		-e '/LUAPATH :=/d' \
		-e '/LUAPATH_FN =/d' \
		-i GNUmakefile || die

	lua_copy_sources
}

lua_src_compile() {
	pushd "${BUILD_DIR}" || die

	if [[ ${ELUA} != luajit ]]; then
		LUA_VERSION="$(ver_cut 1-2 $(lua_get_version))"
	else
		# This is a workaround for luajit, as it confirms to lua5.1
		# and the 'GNUmakefile' doesn't understand LuaJITs version.
		LUA_VERSION="5.1"
	fi

	emake CC="$(tc-getCC)" \
		ALL_CFLAGS="${CFLAGS} -std=gnu99 -fPIC $(lua_get_CFLAGS)" \
		ALL_CPPFLAGS="${CPPFLAGS} -D_GNU_SOURCE" \
		ALL_SOFLAGS="${SOFLAGS} -shared" \
		ALL_LDFLAGS="${LDFLAGS}" \
		all${LUA_VERSION}

	popd
}

src_compile() {
	lua_foreach_impl lua_src_compile
}

lua_src_install() {
	pushd "${BUILD_DIR}" || die

	if [[ ${ELUA} != luajit ]]; then
		LUA_VERSION="$(ver_cut 1-2 $(lua_get_version))"
	else
		# This is a workaround for luajit, as it confirms to lua5.1
		# and the 'GNUmakefile' doesn't understand LuaJITs version.
		LUA_VERSION="5.1"
	fi

	emake "DESTDIR=${D}" \
		"lua${LUA_VERSION/./}cpath=$(lua_get_cmod_dir)" \
		"lua${LUA_VERSION/./}path=$(lua_get_lmod_dir)" \
		"prefix=${EPREFIX}/usr" \
		install${LUA_VERSION}

	popd
}

src_install() {
	lua_foreach_impl lua_src_install

	use examples && dodoc -r "examples/."
	einstalldocs
}
