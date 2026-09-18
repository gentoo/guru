# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} luajit )

inherit lua toolchain-funcs

MY_PN="Lua-cURLv3"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Lua binding to libcurl"
HOMEPAGE="https://github.com/Lua-cURL/Lua-cURLv3"
SRC_URI="
	https://github.com/Lua-cURL/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${LUA_REQUIRED_USE}"
RESTRICT="test" # TODO

RDEPEND="
	${LUA_DEPS}
	net-misc/curl
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-0.3.13-fix-missing-return.patch"
)

src_prepare() {
	default

	sed 's/COMMONFLAGS\s*=.*/COMMONFLAGS = -fPIC $(OS_FLAGS) $(DBG)/' \
		-i Makefile || die

	lua_copy_sources
}

lua_src_compile() {
	pushd "${BUILD_DIR}" >/dev/null || die

	emake CC="$(tc-getCC)"

	popd >/dev/null || die
}

src_compile() {
	lua_foreach_impl lua_src_compile
}

lua_src_install() {
	pushd "${BUILD_DIR}" >/dev/null || die

	emake DESTDIR="${ED}" install

	popd >/dev/null || die
}

src_install() {
	lua_foreach_impl lua_src_install
}
