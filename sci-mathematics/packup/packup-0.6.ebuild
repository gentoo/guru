# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature toolchain-funcs

DESCRIPTION="PACKage Upgradability Problem solver"
HOMEPAGE="https://sat.inesc-id.pt/~mikolas/sw/packup/"
SRC_URI="
	https://sat.inesc-id.pt/~mikolas/sw/${PN}/${P}.tgz
	https://sat.inesc-id.pt/~mikolas/sw/${PN}/${P}.1
	https://sat.inesc-id.pt/~mikolas/sw/${PN}/${P}.1.html
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/gmp
	sys-libs/zlib
"
DEPEND="
	${RDEPEND}
	sci-mathematics/minisat+
"

PATCHES=(
	"${FILESDIR}/${P}-makefile.patch"
	"${FILESDIR}/${P}-spelling.patch"
	"${FILESDIR}/${P}-c++11.patch"
	"${FILESDIR}/${P}-minisat+-invocation.patch"
)

src_compile() {
	tc-export CXX
	emake all
}

src_install() {
	dobin packup
	dodoc README.txt
	docinto html
	dodoc "${DISTDIR}/${P}.1.html"
	doman "${DISTDIR}/${P}.1"
	insinto /usr/share/cudf/solvers
	doins "${FILESDIR}/packup"
}

pkg_postinst() {
	optfeature "optional solver minisatp" sci-mathematics/minisatp
}
