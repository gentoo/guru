# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit flag-o-matic fortran-2

DESCRIPTION="Jacobi-Davidson type method for the generalized standard eigenvalue problem."
HOMEPAGE="https://www.win.tue.nl/casa/research/scientificcomputing/topics/jd/software.html"
SRC_URI="https://www.win.tue.nl/casa/research/scientificcomputing/topics/jd/${PN}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc"

# /usr/lib/gcc/x86_64-pc-linux-gnu/9.3.0/../../../../x86_64-pc-linux-gnu/bin/ld: ../jdlib/libjdqz.so: undefined reference to `zgegs_'
#/usr/lib/gcc/x86_64-pc-linux-gnu/9.3.0/../../../../x86_64-pc-linux-gnu/bin/ld: ../jdlib/libjdqz.so: undefined reference to `zgegv_'
RESTRICT="test"

DEPEND="
	virtual/blas
	virtual/lapack
"
RDEPEND="${DEPEND}"
BDEPEND="doc? ( dev-texlive/texlive-latex )"

S="${WORKDIR}/${PN}"

src_prepare() {
	libs="$($(tc-getPKG_CONFIG) --libs blas)"
	libs+=" $($(tc-getPKG_CONFIG) --libs lapack)"

	export libs

	sed -i 's/f77/${F77}/g' jdtest/Makefile || die
	sed -i '/FFLAGS/d' jdtest/Makefile || die
	sed -i 's/-u -O/-u ${FFLAGS}/g' jdtest/Makefile || die

	sed -i "s/-llapack -lblas/${libs}/" jdtest/Makefile || die

	default
}

src_compile() {
	if use doc; then
		pdflatex manual.tex || die
	fi

	cd "jdlib" || die

	echo '#!/bin/sh' > make.sh || die
	echo "${FC}" *.f "${FFLAGS} -shared -fPIC -Wl,-soname,libjdqz.so.0 -lm ${libs} ${LDFLAGS} -o libjdqz.so.0" >> make.sh || die
	chmod +x make.sh || die

	./make.sh || die
	ln -s libjdqz.so.0 libjdqz.so || die
}

src_test() {
	cd jdtest || die
	emake
	LD_LIBRARY_PATH="./jdlib" ./jdtest/example || die
}

src_install() {
	dolib.so jdlib/libjdqz.so
	dolib.so jdlib/libjdqz.so.0

	use doc && dodoc manual.pdf
}
