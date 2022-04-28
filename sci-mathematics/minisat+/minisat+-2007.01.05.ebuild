# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPV="${PV/.01./-Jan-}"
MYP="${PN}_${MYPV}"

inherit toolchain-funcs

DESCRIPTION="solver for pseudo-Boolean constraints"
HOMEPAGE="https://minisat.se/MiniSat+.html"
SRC_URI="https://minisat.se/downloads/${MYP}.zip"
S="${WORKDIR}/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bignum"

RDEPEND="
	bignum? ( dev-libs/gmp )
	sys-libs/zlib
"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip"

PATCHES=(
	"${FILESDIR}/${P}-makefile.patch"
	"${FILESDIR}/${P}-script.patch"
	"${FILESDIR}/${P}-exitcode.patch"
	"${FILESDIR}/${P}-spelling.patch"
)

src_compile() {
	tc-export CXX
	emake rx
	use bignum && emake rs
}

src_install() {
	dodoc -r Examples
	dobin minisat+_64-bit
	use bignum && dobin minisat+_bignum
	if use bignum; then
		dosym ./minisat+_bignum "${EPREFIX}/usr/bin/minisat+"
	else
		dosym ./minisat+_64-bit "${EPREFIX}/usr/bin/minisat+"
	fi
}
