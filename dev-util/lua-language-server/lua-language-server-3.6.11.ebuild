# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ninja-utils toolchain-funcs

DESCRIPTION="Lua language server"
HOMEPAGE="https://github.com/LuaLS/lua-language-server"
SRC_URI="https://github.com/LuaLS/lua-language-server/releases/download/${PV}/${P}-submodules.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
BDPEND="
	${NINJA_DEPEND}
	app-arch/unzip
	dev-util/ninja
"
RESTRICT="!test? ( test )"
PATCHES=( "${FILESDIR}/linux.ninja.patch" "${FILESDIR}/build.ninja.patch" )

src_prepare() {
	# Remove hardcoded gcc references
	sed -i "/lm.cxx/a lm.cc = '$(tc-getCC)'" \
		make.lua || die
	sed -i "s/CC = gcc/ CC = ${tc-getCC}/" \
		3rd/lpeglabel/makefile || die
	# Shipped file doesn't respect CFLAGS/CXXFLAGS
	eapply "${FILESDIR}/linux.ninja.patch"
	eapply_user
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

	# Generated file doesn't respect CFLAGS/CXXFLAGS
	sed -i -e "s/^cc =.*./cc = REPLACE_ME/" \
		-e "s/^luamake =.*./luamake = LUAMAKE_PATH/" \
		build/build.ninja || die

	eapply "${FILESDIR}/build.ninja.patch"
	sed -i -e "s/REPLACE_ME/$(tc-getCC)/" \
		-e "s|LUAMAKE_PATH|${S}/3rd/luamake/luamake|" \
		-e "s/CFLAGS/${CFLAGS}/" \
		-e "s/CXXFLAGS/${CXXFLAGS}/" \
		-e "s/LDFLAGS/${LDFLAGS}/" \
		-e "7d" \
		build/build.ninja || die

	# Tests are broken
	eninja -f build/build.ninja all
}

src_install() {
	dobin ./bin/{main.lua,lua-language-server}
	dodoc changelog.md README.md
}
