# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_NEED_OPENMP=1
FORTRAN_STANDARD=90
LLVM_MAX_SLOT=14

inherit llvm fortran-2 toolchain-funcs

DESCRIPTION="Scalable Performance Measurement Infrastructure for Parallel Codes"
HOMEPAGE="https://www.vi-hps.org/projects/score-p"
SRC_URI="https://perftools.pages.jsc.fz-juelich.de/cicd/${PN}/tags/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug gcc-plugin llvm mpi online-access +openacc opencl openshmem pmi unwind"

CDEPEND="
	dev-libs/cubelib
	dev-libs/cubew
	dev-libs/papi
	sys-cluster/opari2
	<sys-cluster/otf2-3.0
	sys-libs/binutils-libs:=
	sys-libs/zlib

	llvm? (
		sys-devel/clang:"${LLVM_MAX_SLOT}"
		<sys-devel/llvm-"${LLVM_MAX_SLOT}":=
		|| (
			sys-devel/llvm:12
			sys-devel/llvm:13
			sys-devel/llvm:"${LLVM_MAX_SLOT}"
		)
	)
	mpi? ( virtual/mpi )
	openshmem? ( sys-cluster/SOS )
	pmi? ( || ( sys-cluster/slurm sys-cluster/pmix[pmi] ) )
	unwind? ( || ( sys-libs/libunwind sys-libs/llvm-libunwind ) )
"
RDEPEND="
	${CDEPEND}
	opencl? ( virtual/opencl )
"
DEPEND="
	${CDEPEND}
	opencl? ( dev-util/opencl-headers )
"

pkg_setup() {
	use llvm && llvm_pkg_setup
	fortran-2_pkg_setup
}

src_prepare() {
	tc-export CC CXX FC F77 CPP AR
	# eautoreconf will need custom autotools
	sed -e "s|CC=gcc|CC=${CC}|g" -i build-score/configure || die
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
	CXXFLAGS_FOR_BUILD_SCORE=${CXXFLAGS}
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

	cat > build-config/common/platforms/platform-shmem-user-provided <<-EOF || die
	SHMEMCC=oshcc
	SHMEMCXX=oshc++
	SHMEMF77=oshfort
	SHMEMFC=oshfort
	SHMEM_CPPFLAGS=${CPPFLAGS}
	SHMEM_CFLAGS=${CFLAGS}
	SHMEM_CXXFLAGS=${CXXFLAGS}
	SHMEM_FFLAGS=${FFLAGS}
	SHMEM_FCFLAGS=${FCFLAGS}
	SHMEM_LDFLAGS=${LDFLAGS}
	SHMEM_LIBS=-lsma
	SHMEM_LIB_NAME=libsma
	SHMEM_NAME=sandia-openshmem
	EOF

	rm -r vendor || die
	default
}

src_configure() {

	local myconf=(
		--disable-cuda
		--disable-experimental-platform
		--disable-platform-mic
		--disable-static
		--enable-shared
		--with-cubelib
		--with-cubew
		--with-custom-compilers
		--with-libbfd
		--with-opari2
		--with-otf2
		--with-papi-header="/usr/include"
		--with-papi-lib="/usr/$(get_libdir)"
		--without-libcuda
		--without-libcudart
		--without-libcupti
		--without-liblustreapi
		--without-libnvidia-ml
		--without-librca
		--without-pdt

		$(use_enable debug)
		$(use_enable openacc)
		$(use_with gcc-plugin)
		$(use_with online-access)
		$(use_with opencl libOpenCL)
		$(use_with openshmem shmem openshmem)
		$(use_with pmi)
		$(use_with unwind libunwind)
	)
	if use llvm; then
		myconf+=( "--with-llvm=$(get_llvm_prefix)/bin" )
	else
		myconf+=( "--without-llvm" )
	fi
	use mpi || myconf+=( "--without-mpi" )

	econf "${myconf[@]}"
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
