# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# lua-bit32 dependency does not yet support newer Lua implementations
LUA_COMPAT=( lua5-1 luajit )

inherit lua toolchain-funcs

DESCRIPTION="A collection of interactive command line prompts for Lua"
HOMEPAGE="https://github.com/giann/sirocco"
EGIT_COMMIT="b2af2d336e808e763b424d2ea42e6a2c2b4aa24d"
SRC_URI="https://github.com/giann/sirocco/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="examples"

REQUIRED_USE="${LUA_REQUIRED_USE}"

DEPEND="${LUA_DEPS}"
RDEPEND="
	dev-lua/lua-term[${LUA_USEDEP}]
	dev-lua/hump[${LUA_USEDEP}]
	dev-lua/lua-wcwidth[${LUA_USEDEP}]
	dev-lua/compat53[${LUA_USEDEP}]
	dev-lua/lua-bit32[${LUA_USEDEP}]
	${LUA_DEPS}
"

lua_src_compile() {
	local compiler=(
		"$(tc-getCC)"
		"${CFLAGS}"
		"-fPIC"
		"$(lua_get_CFLAGS)"
		"-c sirocco/winsize.c"
		"-o winsize.o"
	)
	einfo "${compiler[@]}"
	${compiler[@]} || die

	local linker=(
		"$(tc-getCC)"
		"-shared"
		"${LDFLAGS}"
		"-o winsize.so"
		"winsize.o"
	)
	einfo "${linker[@]}"
	${linker[@]} || die
}

src_compile() {
	lua_foreach_impl lua_src_compile
}

lua_src_install() {
	exeinto "$(lua_get_cmod_dir)/${PN}"
	doexe winsize.so
	insinto "$(lua_get_lmod_dir)/${PN}"
	doins sirocco/*.lua
}

src_install() {
	lua_foreach_impl lua_src_install
	dodoc README.md
	if use examples; then
		docinto examples
		dodoc example-wrapped.lua example.lua
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
