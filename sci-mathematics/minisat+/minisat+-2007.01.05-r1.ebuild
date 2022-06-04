# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

COMMIT="e9dcbabbf5399d16ed4b09250307d1165a341160"
DESCRIPTION="solver for pseudo-Boolean constraints"
HOMEPAGE="http://minisat.se/MiniSat+.html"
DOWNLOADS_URI="https://github.com/niklasso/minisat-webpage/raw/${COMMIT}/downloads"
SRC_URI="
	${DOWNLOADS_URI}/${PN}_${PV/.01./-Jan-}.zip
	doc? ( ${DOWNLOADS_URI}/MiniSat+.pdf )
"
S="${WORKDIR}/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bignum doc"

RDEPEND="
	bignum? ( dev-libs/gmp:= )
	sys-libs/zlib:=
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
	use doc && dodoc "${DISTDIR}"/MiniSat+.pdf
	dodoc -r Examples

	dobin minisat+_64-bit
	use bignum && dobin minisat+_bignum
	if use bignum; then
		dosym ./minisat+_bignum usr/bin/minisat+
	else
		dosym ./minisat+_64-bit /usr/bin/minisat+
	fi
}
