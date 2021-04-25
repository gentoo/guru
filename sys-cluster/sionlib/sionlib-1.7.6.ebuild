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
#TODO: cuda sionfwd msa
#--enable-sionfwd=/path/to/sionfwd
#--msa=(hostname-regex|deep-est-sdv)]	MSA aware collective operations for the given system

PATCHES=( "${FILESDIR}/respect-flags.patch" )

RDEPEND="
	${PYTHON_DEPS}
	mpi? ( virtual/mpi )
	ompi? (
		sys-libs/libomp
		virtual/mpi
	)
	openmp? ( sys-libs/libomp )
"
DEPEND="${RDEPEND}"
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
		--prefix="${EPREFIX}/usr"
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
	default
	use doc && doxygen -u doxy && doxygen doxy || die
}

src_install() {
	sed -e "s|\${PREFIX}|${D}/usr|g" -i mf/common.defs || die
	sed -e "s|\$(PREFIX)|${D}/usr|g" -i src/utils/Makefile || die
	sed \
		-e "s|\$(PREFIX)|${D}/usr|g" \
		-e "s|\${PREFIX}|${D}/usr|g" \
		-i mf/RealMakefile || die

	default

	use doc && dodoc -r doc/html

	mv "${ED}/usr/examples" "${ED}/usr/share/doc/${PF}/" || die
	docompress -x "/usr/share/doc/${PF}/examples"
	docompress -x "/usr/share/doc/${PF}/html"

	#TODO: build shared libs
	#find "${ED}" -name '*.a' -delete || die
	find "${ED}" -name '*.la' -delete || die
}
