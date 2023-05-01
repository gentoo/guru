# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{10..11} )

inherit python-single-r1 toolchain-funcs

DESCRIPTION="highly scalable, memory efficient event trace data format"
HOMEPAGE="https://www.vi-hps.org/projects/score-p"
SRC_URI="https://perftools.pages.jsc.fz-juelich.de/cicd/otf2/tags/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/2.3"
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
	rm build-config/common/platforms/platform-* || die

	cat > build-config/common/platforms/platform-backend-user-provided <<-EOF || die
	CC=${CC}
	CXX=${CXX}
	FC=${FC}
	F77=${F77}
	CPP=${CPP}
	CXXCPP=${CPP}
	EOF

	cat > build-config/common/platforms/platform-frontend-user-provided <<-EOF || die
	CC_FOR_BUILD=${CC}
	F77_FOR_BUILD=${F77}
	FC_FOR_BUILD=${FC}
	CXX_FOR_BUILD=${CXX}
	LDFLAGS_FOR_BUILD=${LDFLAGS}
	CFLAGS_FOR_BUILD=${CFLAGS}
	CXXFLAGS_FOR_BUILD=${CXXFLAGS}
	CPPFLAGS_FOR_BUILD=${CPPFLAGS}
	FCFLAGS_FOR_BUILD=${FCFLAGS}
	FFLAGS_FOR_BUILD=${FFLAGS}
	EOF

	cat > build-config/common/platforms/platform-mpi-user-provided <<-EOF || die
	MPICC=mpicc
	MPICXX=mpicxx
	MPIF77=mpif77
	MPIFC=mpif90
	MPI_CPPFLAGS=${CPPFLAGS}
	MPI_CFLAGS=${CFLAGS}
	MPI_CXXFLAGS=${CXXFLAGS}
	MPI_FFLAGS=${FFLAGS}
	MPI_FCFLAGS=${FCFLAGS}
	MPI_LDFLAGS=${LDFLAGS}
	EOF

	local myconf=(
		--disable-platform-mic
		--disable-static
		--enable-shared
		--with-custom-compilers

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
