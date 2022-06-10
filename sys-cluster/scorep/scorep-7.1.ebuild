# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_MAX_SLOT=14

inherit autotools llvm fortran-2 toolchain-funcs

DESCRIPTION="Scalable Performance Measurement Infrastructure for Parallel Codes"
HOMEPAGE="https://www.vi-hps.org/projects/score-p"
SRC_URI="https://perftools.pages.jsc.fz-juelich.de/cicd/${PN}/tags/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug gcc-plugin llvm mpi online-access opencl openshmem pmi unwind"

CDEPEND="
	dev-libs/cubelib
	dev-libs/cubew
	dev-libs/papi
	sys-cluster/opari2
	sys-cluster/otf2
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

#PATCHES=( "${FILESDIR}/${P}-respect-flags.patch" )

pkg_setup() {
	llvm_pkg_setup
	fortran-2_pkg_setup
}

src_prepare() {
	rm -r vendor || die
	default
	eautoreconf
}

src_configure() {
	tc-export CC CXX FC F77 CPP

	if use openshmem; then
		export SHMEMCC="oshcc"
		export SHMEMCXX="oshc++"
		export SHMEMF77="oshfort"
		export SHMEMFC="oshfort"
		export SHMEM_CPPFLAGS="${CPPFLAGS}"
		export SHMEM_CFLAGS="${CFLAGS}"
		export SHMEM_CXXFLAGS="${CXXFLAGS}"
		export SHMEM_FFLAGS="${FFLAGS}"
		export SHMEM_FCFLAGS="${FCFLAGS}"
		export SHMEM_LDFLAGS="${LDFLAGS}"
		export SHMEM_LIBS="-lsma"
		export SHMEM_LIB_NAME="libsma"
		export SHMEM_NAME="sandia-openshmem"
	fi

	local myconf=(
		--disable-cuda
		--disable-experimental-platform
		--disable-openacc
		--disable-platform-mic
		--disable-static
		--enable-shared
		--with-cubelib
		--with-cubew
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
