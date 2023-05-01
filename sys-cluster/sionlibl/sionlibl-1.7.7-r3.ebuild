# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="doxygen"
DOCS_CONFIG_NAME="doxy"
FORTRAN_NEEDED="fortran"
PYTHON_COMPAT=( pypy3 python3_{10..11} )

inherit docs edo flag-o-matic fortran-2 python-any-r1 toolchain-funcs

DESCRIPTION="Scalable I/O library for parallel access to task-local files"
HOMEPAGE="https://www.fz-juelich.de/ias/jsc/EN/Expertise/Support/Software/SIONlib/_node.html"
SRC_URI="http://apps.fz-juelich.de/jsc/sionlib/download.php?version=${PV}l -> ${PN}l-${PV}.tar.gz"
S="${WORKDIR}/sionlib"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cxx debug deep-est-sdv doc examples +fortran hostname-regex +mpi +ompi +openmp +parutils +pthreads python sionfwd" #cuda

RDEPEND="
	mpi? ( virtual/mpi )
	openmp? ( || ( sys-devel/gcc:*[openmp] sys-libs/libomp ) )
	sionfwd? ( sys-cluster/SIONfwd )
"
DEPEND="
	${RDEPEND}
	${PYTHON_DEPS}
"

REQUIRED_USE="
	ompi? ( mpi openmp )
	?? ( hostname-regex deep-est-sdv )
"
PATCHES=(
	"${FILESDIR}/${PN}-respect-flags-v3.patch"
	"${FILESDIR}/${PN}-build-shared-libraries.patch"
)

pkg_setup() {
	FORTRAN_NEED_OPENMP=0
	use openmp && FORTRAN_NEED_OPENMP=1

	fortran-2_pkg_setup
}

src_configure() {
	tc-export AR CC CXX F77 FC
	export MPICC=/usr/bin/mpicc
	export MPICXX=/usr/bin/mpicxx
	export MPIF77=/usr/bin/mpif77
	export MPIF90=/usr/bin/mpif90
	export F90=$(tc-getFC)
	export OMPF77=$(tc-getF77)
	export OMPF90=$(tc-getFC)

	append-fflags -fallow-argument-mismatch

	local msa="none"
	use deep-est-sdv && msa="deep-est-sdv"
	use hostname-regex && msa="hostname-regex"

	local myconf=(
		--disable-gcovr
		--disable-kcov
		--disable-mic
		--msa="${msa}"
		--prefix="${T}/prefix/usr"
		$(use_enable debug)
		$(use_enable pthreads)
	)

	#custom configure?
	use cxx || myconf+=( "--disable-cxx" )
	use fortran || myconf+=( "--disable-fortran" )
	if use mpi; then
		myconf+=( "--mpi=$(detect_mpi_implementation || die)" )
	else
		myconf+=( "--disable-mpi" )
	fi
	use ompi || myconf+=( "--disable-ompi" )
	use openmp || myconf+=( "--disable-omp" )
	use parutils || myconf+=( "--disable-parutils" )

	use python && myconf+=( "--enable-python=3" )
	use sionfwd && myconf+=( "--enable-sionfwd=${EPREFIX}/usr" )

	edo ./configure "${myconf[@]}"
}

src_compile() {
	export VARTEXFONTS="${T}/fonts"
	emake C_AR=$(tc-getAR) F90=$(tc-getFC)
	docs_compile
}

src_install() {
	mkdir -p "${T}/prefix/usr/share/doc/${PF}" || die
	default

	if use examples ; then
		mv "${T}/prefix/usr/examples" "${T}/prefix/usr/share/doc/${PF}/" || die
	else
		rm -r "${T}/prefix/usr/examples" || die
	fi

	insinto "/usr/include/sionlibl"
	doins -r "${T}"/prefix/usr/include/*
	rm -r "${T}/prefix/usr/include" || die

	exeinto "/usr/libexec/${PN}"
	doexe "${T}"/prefix/usr/bin/*partest
	rm "${T}"/prefix/usr/bin/*partest || die

	for b in "${T}"/prefix/usr/bin/sion* ; do
		n=$(basename "${b}")
		newbin "${T}/prefix/usr/bin/${n}" "l${n}"
		rm "${b}" || die
	done

	# move 64 bit libraries to lib64
	libs64=( "${T}"/prefix/usr/lib/*64* )
	if [[ ${#libs64[@]} -gt 0 ]]; then
		mkdir "${T}/prefix/usr/lib64" || die
		for l in "${libs64[@]}" ; do
			mv "${l}" "${T}/prefix/usr/lib64/" || die
		done
	fi

	rsync -ravXHA "${T}/prefix/usr" "${ED}/" || die
	docompress -x "/usr/share/doc/${PF}/examples"

	#TODO: build shared libs
	#find "${ED}" -name '*.a' -delete || die
	find "${ED}" -name '*.la' -delete || die
}

detect_mpi_implementation() {
	cat > testmpi.c <<- EOF
#include "mpi.h"
#include "stdio.h"

int main(){
	#ifdef OPEN_MPI
	        printf("%s","openmpi");
	#endif

	#ifdef MPICH
	        printf("%s%i","mpich",MPICH_NAME);
	#endif
	return 0;
}
EOF
	edo ${CC} testmpi.c -o testmpi
	./testmpi || die
}
