# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

DESCRIPTION="A cross-platform build utility based on Lua"
HOMEPAGE="https://xmake.io"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/xmake-io/${PN}.git"
else
	SRC_URI="https://github.com/xmake-io/${PN}/releases/download/v${PV}/${PN}-v${PV}.tar.gz"
	KEYWORDS="~amd64 ~riscv ~x86"
fi

# tarball doesn't provide tests
RESTRICT="test strip"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND="
	sys-libs/ncurses:=
	sys-libs/readline:=
"
BDEPEND="
	virtual/pkgconfig
"
RDEPEND="
	${DEPEND}
	${BDEPEND}
"

DOCS=(
	CHANGELOG.md CODE_OF_CONDUCT.md CONTRIBUTING.md
	NOTICE.md README.md README_zh.md
)

src_configure(){
	econf --prefix="${EPREFIX}"/usr \
		--plat=linux
		# --plat=linux is necessary, which enables correct directory:
		# build/linux/ARCH other than build/ARCH/ARCH
}

pkg_postinst() {
	optfeature "cached compilation for your xmake projects" dev-util/ccache
}
