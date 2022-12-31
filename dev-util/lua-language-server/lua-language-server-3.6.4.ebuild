# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ninja-utils

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
	sys-devel/gcc
"
RESTRICT="!test? ( test )"

src_compile() {
	eninja -C 3rd/luamake -f compile/ninja/linux.ninja $(usex test '' 'luamake')
	./3rd/luamake/luamake $(usex test '' 'all') || die
}

src_install() {
	dobin ./bin/{main.lua,lua-language-server}
	dodoc changelog.md README.md
}
