# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic fortran-2 toolchain-funcs

DESCRIPTION="Jacobi-Davidson type method for the generalized standard eigenvalue problem"
HOMEPAGE="https://www.win.tue.nl/~hochsten/jd/"
SRC_URI="https://www.win.tue.nl/~hochsten/jd/${PN}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="doc test"

# virtual/lapack does not pull in [deprecated] so we have to deal with this mess like this until it does
DEPEND="
	virtual/blas
	virtual/lapack
	|| ( sci-libs/openblas !sci-libs/lapack[-deprecated(-)] )
"
RDEPEND="${DEPEND}"
BDEPEND="doc? ( dev-texlive/texlive-latex )"

PATCHES=( "${FILESDIR}/makefile.patch" )
RESTRICT="!test? ( test )"

src_compile() {
	local pkgc="$(tc-getPKG_CONFIG)"
	append-fflags "$(${pkgc} --libs blas) $(${pkgc} --libs lapack)"
	if use doc; then
		pdflatex manual.tex || die
	fi

	pushd "jdlib" || die
	emake
	ln -s libjdqz.so.0 libjdqz.so || die
}

src_test() {
	pushd "jdtest" || die
	emake
	popd || die
	LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:./jdlib" ./jdtest/example || die
}

src_install() {
	dolib.so jdlib/libjdqz.so
	dolib.so jdlib/libjdqz.so.0

	use doc && dodoc manual.pdf
}
