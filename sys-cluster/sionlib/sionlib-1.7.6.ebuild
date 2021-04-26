# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

FORTRAN_NEEDED="fortran"
PYTHON_COMPAT=( pypy3 python3_{7,8,9} )
inherit flag-o-matic fortran-2 python-any-r1 toolchain-funcs

DESCRIPTION="Scalable I/O library for parallel access to task-local files"
HOMEPAGE="https://www.fz-juelich.de/ias/jsc/EN/Expertise/Support/Software/SIONlib/_node.html"
SRC_URI="http://apps.fz-juelich.de/jsc/sionlib/download.php?version=${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cxx debug doc +fortran +mpi +ompi +openmp +parutils +pthreads python"
#TODO: fix installation in multilib
#TODO: cuda sionfwd msa
#--enable-sionfwd=/path/to/sionfwd
#--msa=(hostname-regex|deep-est-sdv)]	MSA aware collective operations for the given system

PATCHES=( "${FILESDIR}/respect-flags.patch" )

RDEPEND="
	mpi? ( virtual/mpi )
	ompi? (
		sys-libs/libomp
		virtual/mpi
	)
	openmp? ( sys-libs/libomp )
"
DEPEND="
	${RDEPEND}
	${PYTHON_DEPS}
"
BDEPEND="doc? ( app-doc/doxygen )"
S="${WORKDIR}/${PN}"

pkg_setup() {
	FORTRAN_NEED_OPENMP=0
	use openmp && FORTRAN_NEED_OPENMP=1
	use ompi && FORTRAN_NEED_OPENMP=1

	fortran-2_pkg_setup
}

src_configure() {
	export AR=$(tc-getAR)
	export CC=$(tc-getCC)
	export CXX=$(tc-getCXX)
	export MPICC=/usr/bin/mpicc
	export MPICXX=/usr/bin/mpicxx
	export MPIF77=/usr/bin/mpif77
	export MPIF90=/usr/bin/mpif90
	export F77=$(tc-getF77)
	export F90=$(tc-getFC)
	export OMPF77=$(tc-getF77)
	export OMPF90=$(tc-getFC)

	append-fflags -fallow-argument-mismatch

	local myconf=(
		--disable-mic
		--prefix="${T}/prefix/usr"
	)

	#custom configure?
	use cxx || myconf+=( "--disable-cxx" )
	use fortran || myconf+=( "--disable-fortran" )
	use mpi || myconf+=( "--disable-mpi" )
	use ompi || myconf+=( "--disable-ompi" )
	use openmp || myconf+=( "--disable-omp" )
	use parutils || myconf+=( "--disable-parutils" )
	use pthreads || myconf+=( "--disable-pthreads" )

	use debug && myconf+=( "--enable-debug" )
	use python && myconf+=( "--enable-python=3" )

	./configure "${myconf[@]}" || die
}

src_compile() {
	export VARTEXFONTS="${T}/fonts"
	default
	if use doc ; then
		doxygen -u doxy || die
		doxygen doxy || die
	fi
}

src_install() {
	mkdir -p "${T}/prefix/usr/share/doc/${PF}" || die
	default

	mv "${T}/prefix/usr/examples" "${T}/prefix/usr/share/doc/${PF}/" || die
	rsync -ravXHA "${T}/prefix/usr" "${ED}/" || die
	docompress -x "/usr/share/doc/${PF}/examples"

	use doc && dodoc -r doc/html
	use doc && docompress -x "/usr/share/doc/${PF}/html"

	#TODO: build shared libs
	#find "${ED}" -name '*.a' -delete || die
	find "${ED}" -name '*.la' -delete || die
}
