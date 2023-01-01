# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ninja-utils toolchain-funcs

DESCRIPTION="Lua language server"
HOMEPAGE="https://github.com/sumneko/lua-language-server"
SRC_URI="https://github.com/sumneko/lua-language-server/releases/download/${PV}/${P}-submodules.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
BDPEND="
	${NINJA_DEPEND}
	app-arch/unzip
	dev-util/ninja
"
RESTRICT="!test? ( test )"
PATCHES=( "${FILESDIR}/linux.ninja.patch" )

src_prepare() {
	# Remove hardcoded gcc references
	sed -i "/lm.cxx/a lm.cc = '$(tc-getCC)'" \
		make.lua || die
	sed -i "s/CC = gcc/ CC = ${tc-getCC}/" \
		3rd/lpeglabel/makefile || die
	sed -i "s/flags = \"-Wall -Werror\"/flags =\"${CXXFLAGS}\"/" \
		make/code_format.lua || die
	# Patch
	default
	# Shipped file doesn't respect CFLAGS/CXXFLAGS
	sed -i -e "s/^cc = REPLACE_ME/cc = $(tc-getCC)/" \
		-e "s/CFLAGS/${CFLAGS}/" \
		-e "s/CXXFLAGS/${CXXFLAGS}/" \
		-e "s/LDFLAGS/${LDFLAGS}/" \
		3rd/luamake/compile/ninja/linux.ninja || die
}

src_compile() {
	eninja -C 3rd/luamake -f compile/ninja/linux.ninja "$(usex test "test" "luamake")"
	use test && eninja -C 3rd/luamake -f compile/ninja/linux.ninja luamake
	./3rd/luamake/luamake init || die

	eapply "${FILESDIR}/build.ninja.patch"

	sed -i "s/^cc = gcc/cc = $(tc-getCC)/" \
		build/build.ninja || die

	# Generated file doesn't respect CFLAGS/CXXFLAGS
	sed -i -e "s/^cc = REPLACE_ME/cc = $(tc-getCC)/" \
		-e "s/CFLAGS/${CFLAGS}/" \
		-e "s/CXXFLAGS/${CXXFLAGS}/" \
		-e "s/LDFLAGS/${LDFLAGS}/" \
		build/build.ninja || die

	# Tests are broken
	eninja -f build/build.ninja all
}

src_install() {
	dobin ./bin/{main.lua,lua-language-server}
	dodoc changelog.md README.md
}
