# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Lightweight, general, scalable C++ library for finite element methods"
HOMEPAGE="
	https://mfem.org/
	https://github.com/mfem/mfem/
"
SRC_URI="https://github.com/mfem/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"
IUSE_AMDGPU="
	amdgpu_gfx701 amdgpu_gfx702 amdgpu_gfx704
	amdgpu_gfx802 amdgpu_gfx803 amdgpu_gfx805 amdgpu_gfx810
	amdgpu_gfx900 amdgpu_gfx904 amdgpu_gfx906 amdgpu_gfx908 amdgpu_gfx909 amdgpu_gfx90a amdgpu_gfx940
	amdgpu_gfx1010 amdgpu_gfx1011 amdgpu_gfx1012 amdgpu_gfx1030 amdgpu_gfx1031 amdgpu_gfx1032 amdgpu_gfx1034
	amdgpu_gfx1100 amdgpu_gfx1101 amdgpu_gfx1102
"
cpuflags="
	cpu_flags_x86_mmx cpu_flags_x86_mmxext cpu_flags_x86_sse cpu_flags_x86_sse2 cpu_flags_x86_sse3
	cpu_flags_x86_ssse3 cpu_flags_x86_sse4a cpu_flags_x86_sse4_1 cpu_flags_x86_sse4_2 cpu_flags_x86_avx
	cpu_flags_x86_avx2 cpu_flags_x86_avx512dq cpu_flags_x86_avx512f cpu_flags_x86_avx512vl
	cpu_flags_x86_3dnow cpu_flags_x86_3dnowext cpu_flags_ppc_vsx cpu_flags_ppc_vsx2 cpu_flags_ppc_vsx3
	cpu_flags_ppc_altivec cpu_flags_arm_neon cpu_flags_arm_iwmmxt cpu_flags_arm_iwmmxt2 cpu_flags_arm_neon
"
IUSE="
	${IUSE_AMDGPU}
	${cpuflags}
	benchmark codipack debug examples exceptions ginkgo hip lapack +metis mpfr mpi mumps netcdf openmp petsc slepc sparse ssl strumpack sundials superlu test threadsafe unwind zlib
"
# TODO: cuda mesquite gslib moonolith

RDEPEND="
	benchmark? ( dev-cpp/benchmark )
	codipack? ( sci-libs/CoDiPack )
	ginkgo? ( sci-libs/ginkgo )
	hip? (
		sci-libs/hipSPARSE
		dev-util/hip
	)
	lapack? (
		virtual/blas
		virtual/lapack
	)
	metis? ( sci-libs/metis )
	mpfr? ( dev-libs/mpfr )
	mpi? (
		sci-libs/hypre[mpi]
		virtual/mpi[cxx]
	)
	mumps? ( sci-libs/mumps[mpi] )
	netcdf? ( sci-libs/netcdf )
	petsc? ( sci-mathematics/petsc[mpi] )
	slepc? ( sci-mathematics/slepc[mpi] )
	sparse? (
		sci-libs/amd
		sci-libs/btf
		sci-libs/camd
		sci-libs/ccolamd
		sci-libs/cholmod
		sci-libs/colamd
		sci-libs/klu
		sci-libs/umfpack
	)
	ssl? ( net-libs/gnutls )
	strumpack? ( sci-libs/STRUMPACK )
	sundials? (
		sci-libs/sundials
		mpi? ( sci-libs/sundials[hypre,mpi] )
	)
	superlu? ( sci-libs/superlu_dist )
	unwind? ( || ( sys-libs/libunwind sys-libs/llvm-libunwind ) )
	zlib? ( sys-libs/zlib )
"
DEPEND="${RDEPEND}"
BDEPEND="app-text/doxygen[dot]"

PATCHES=( "${FILESDIR}/${P}-bump-cmake-version.patch" )
RESTRICT="!test? ( test )"
DOCS=( README CHANGELOG CITATION.cff )
REQUIRED_USE="
	hip? ( || ( ${IUSE_AMDGPU/+/} ) )
	mpi? ( metis )
	mumps? ( mpi )
	petsc? ( mpi )
	slepc? ( petsc )
	strumpack? ( mpi )
	superlu? ( mpi )
"
#pumi? ( mpi )
#?? ( cuda hip )

src_configure() {
	if use hip ; then
		HIP_ARCH=""
		for u in ${IUSE_AMDGPU} ; do
			if use ${u} ; then
				HIP_ARCH="${HIP_ARCH};${u/amdgpu_/}"
			fi
		done
		# remove first character (;)
		HIP_ARCH="${HIP_ARCH:1}"
		export HIP_ARCH
	fi
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DMFEM_ENABLE_MINIAPPS=ON
		-DMFEM_USE_ADIOS2=NO
		-DMFEM_USE_AMGX=NO
		-DMFEM_USE_CALIPER=NO
		-DMFEM_USE_CEED=NO
		-DMFEM_USE_CONDUIT=NO
		-DMFEM_USE_CUDA=NO
		-DMFEM_USE_FMS=NO
		-DMFEM_USE_GSLIB=NO
		-DMFEM_USE_HIOP=NO
		-DMFEM_USE_MKL_CPARDISO=NO
		-DMFEM_USE_OCCA=NO
		-DMFEM_USE_PARELAG=NO
		-DMFEM_USE_PUMI=NO
		-DMFEM_USE_RAJA=NO
		-DMFEM_USE_SIDRE=NO
		-DMFEM_USE_UMPIRE=NO

		-DMFEM_DEBUG=$(usex debug)
		-DMFEM_ENABLE_EXAMPLES=$(usex examples)
		-DMFEM_ENABLE_TESTING=$(usex test)
		-DMFEM_THREAD_SAFE=$(usex threadsafe)
		-DMFEM_USE_BENCHMARK=$(usex benchmark)
		-DMFEM_USE_CODIPACK=$(usex codipack)
		-DMFEM_USE_EXCEPTIONS=$(usex exceptions)
		-DMFEM_USE_GINKGO=$(usex ginkgo)
		-DMFEM_USE_GNUTLS=$(usex ssl)
		-DMFEM_USE_HIP=$(usex hip)
		-DMFEM_USE_LAPACK=$(usex lapack)
		-DMFEM_USE_LIBUNWIND=$(usex unwind)
		-DMFEM_USE_METIS=$(usex metis)
		-DMFEM_USE_MPFR=$(usex mpfr)
		-DMFEM_USE_MPI=$(usex mpi)
		-DMFEM_USE_MUMPS=$(usex mumps)
		-DMFEM_USE_NETCDF=$(usex netcdf)
		-DMFEM_USE_OPENMP=$(usex openmp)
		-DMFEM_USE_PETSC=$(usex petsc)
		-DMFEM_USE_SLEPC=$(usex slepc)
		-DMFEM_USE_STRUMPACK=$(usex strumpack)
		-DMFEM_USE_SUITESPARSE=$(usex sparse)
		-DMFEM_USE_SUPERLU=$(usex superlu)
		-DMFEM_USE_ZLIB=$(usex zlib)
	)
	if use codipack; then
		mycmakeargs+=( "-DCODIPACK_INCLUDE_DIR=${EPREFIX}/usr/include/codi" )
	fi
#	if use moonolith; then
#		mycmakeargs+=( "-DMFEM_USE_MOONOLITH=ON" )
#	fi
	if use mpi; then
		mycmakeargs+=( "-DHYPRE_INCLUDE_DIR=${EPREFIX}/usr/include/hypre" )
	fi
	if use petsc; then
		mycmakeargs+=( "-DPETSC_DIR=${EPREFIX}/usr/$(get_libdir)/petsc" )
		mycmakeargs+=( "-DPETSC_ARCH=" )
	fi
	local simd=OFF
	for f in ${cpuflags} ; do
		if use ${f} ; then
			simd=ON
			break
		fi
	done
	mycmakeargs+=( "-DMFEM_USE_SIMD=${simd}" )
	cmake_src_configure
}

src_install() {
	cmake_src_install
	einstalldocs
	# https://github.com/mfem/mfem/issues/3019
	mv "${ED}/usr/lib" _lib || die
	mv _lib "${ED}/usr/$(get_libdir)" || die
}
