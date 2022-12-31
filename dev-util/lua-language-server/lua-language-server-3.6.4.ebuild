# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ninja-utils git-r3

DESCRIPTION="Lua language server"
HOMEPAGE="https://github.com/sumneko/lua-language-server"
SRC_URI="https://github.com/sumneko/lua-language-server/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
BDPEND="
	"${NINJA_DEPEND}"
	dev-util/ninja
	sys-devel/gcc
"

EGIT_REPO_URI="https://github.com/sumneko/lua-language-server"

src_compile() {
	(cd 3rd/luamake && ./compile/install.sh) || die
	./3rd/luamake/luamake make || die
}

src_install() {
	dobin bin/{main.lua,lua-language-server}
	dodoc changelog.md README.md
}
