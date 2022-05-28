# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{8..11} )

inherit python-single-r1 toolchain-funcs

DESCRIPTION="highly scalable, memory efficient event trace data format"
HOMEPAGE="https://www.vi-hps.org/projects/score-p"
SRC_URI="https://perftools.pages.jsc.fz-juelich.de/cicd/otf2/tags/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug sionlib test"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/six[${PYTHON_USEDEP}]')

	sionlib? ( sys-cluster/sionlibl:= )
"
DEPEND="${RDEPEND}"

#RESTRICT="!test? ( test )"
RESTRICT="test" #tests are failing
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
PATCHES=( "${FILESDIR}/${P}-respect-flags.patch" )

src_configure() {
	tc-export CC CXX FC F77 CPP

	export MPICC=/usr/bin/mpicc
	export MPICXX=/usr/bin/mpicxx
	export MPIF77=/usr/bin/mpif77
	export MPIFC=/usr/bin/mpifc

	export MPI_CFLAGS="${CFLAGS}"
	export MPI_CXXFLAGS="${CXXFLAGS}"
	export MPI_CPPFLAGS="${CPPFLAGS}"
	export MPI_F77LAGS="${F77FLAGS}"
	export MPI_FCLAGS="${FCFLAGS}"
	export MPI_LDFLAGS="${LDFLAGS}"

	local myconf=(
		--disable-platform-mic
		--disable-static
		--enable-shared

		$(use_enable test backend-test-runs)
		$(use_enable debug)
	)

	if use sionlib; then
		myconf+=( "--with-sionlib=${EPREFIX}/usr" )
		myconf+=( "--with-sionlib-headers=${EPREFIX}/usr/include/sionlibl" )
	else
		myconf+=( "--without-sionlib" )
	fi

	econf "${myconf[@]}"
}

src_install() {
	default

	find "${ED}" -name '*.la' -delete || die
}
