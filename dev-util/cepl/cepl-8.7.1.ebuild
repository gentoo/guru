# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="A readline C and C++ REPL with history and undo."
HOMEPAGE="https://github.com/alyptik/cepl"
SRC_URI="https://github.com/alyptik/cepl/releases/download/v${PV}/${P}.tar.gz"
S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	sys-libs/readline:=
	virtual/libelf:=
	"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i "s/gcc/$(tc-getCC)/" "${WORKDIR}/t/testcompile.c"
	eapply_user
}

src_compile() {
	tc-export CC
	export {C,LD}FLAGS
	emake cepl
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
