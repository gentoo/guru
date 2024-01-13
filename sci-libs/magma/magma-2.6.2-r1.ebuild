# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_STANDARD="77 90"
PYTHON_COMPAT=( python3_{10..11} )

inherit cmake fortran-2 python-any-r1 toolchain-funcs

MY_PV=$(ver_rs 3 '-')

DESCRIPTION="Matrix Algebra on GPU and Multicore Architectures"
HOMEPAGE="
	https://icl.cs.utk.edu/magma/
	https://bitbucket.org/icl/magma
"
SRC_URI="https://icl.cs.utk.edu/projectsfiles/${PN}/downloads/${PN}-${MY_PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE_AMDGPU="
	amdgpu_gfx701 amdgpu_gfx702 amdgpu_gfx704
	amdgpu_gfx802 amdgpu_gfx803 amdgpu_gfx805 amdgpu_gfx810
	amdgpu_gfx900 amdgpu_gfx904 amdgpu_gfx906 amdgpu_gfx908 amdgpu_gfx909 amdgpu_gfx90a amdgpu_gfx940
	amdgpu_gfx1010 amdgpu_gfx1011 amdgpu_gfx1012 amdgpu_gfx1030 amdgpu_gfx1031 amdgpu_gfx1032 amdgpu_gfx1034
	amdgpu_gfx1100 amdgpu_gfx1101 amdgpu_gfx1102
"
IUSE="doc openblas test ${IUSE_AMDGPU}"
#IUSE="doc cuda hip openblas test ${IUSE_AMDGPU}"

# TODO: do not enforce openblas
#	hip? ( sci-libs/hipBLAS )
RDEPEND="
	sci-libs/hipBLAS
	openblas? ( sci-libs/openblas )
	!openblas? (
		virtual/blas
		virtual/lapack
	)
"
DEPEND="
	${RDEPEND}
	${PYTHON_DEPS}
	dev-util/hip
"
#	hip? ( dev-util/hip )
BDEPEND="
	virtual/pkgconfig
	doc? ( >=app-text/doxygen-1.8.14-r1[dot] )
"

REQUIRED_USE="
	|| ( ${IUSE_AMDGPU/+/} )
"
#	^^ ( cuda hip )
RESTRICT="!test? ( test )"

pkg_setup() {
	fortran-2_pkg_setup
	python-any-r1_pkg_setup
	tc-check-openmp || die "Need OpenMP to compile ${P}"
}

src_prepare() {
	gpu=""
	#if use hip ; then
		for u in ${IUSE_AMDGPU} ; do
			if use ${u} ; then
				gpu="${gpu};${u/amdgpu_/}"
			fi
		done
	#fi
	# remove first character (;)
	gpu="${gpu:1}"
	export gpu

	# distributed pc file not so useful so replace it
	cat <<-EOF > ${PN}.pc
		prefix=${EPREFIX}/usr
		libdir=\${prefix}/$(get_libdir)
		includedir=\${prefix}/include/${PN}
		Name: ${PN}
		Description: ${DESCRIPTION}
		Version: ${PV}
		URL: ${HOMEPAGE}
		Libs: -L\${libdir} -lmagma
		Libs.private: -lm -lpthread -ldl
		Cflags: -I\${includedir}
		Requires: $(usex openblas "openblas" "blas lapack")
	EOF

	#use cuda && echo -e 'BACKEND = cuda' > make.inc
	#use hip && echo -e 'BACKEND = hip' > make.inc
	echo -e 'BACKEND = hip' > make.inc
	echo -e 'FORT = true' >> make.inc
	echo -e "GPU_TARGET = ${gpu}" >> make.inc
	emake generate

	rm -r blas_fix || die

	cmake_src_prepare
}

src_configure() {
	# other options: Intel10_64lp, Intel10_64lp_seq, Intel10_64ilp, Intel10_64ilp_seq, Intel10_32, FLAME, ACML, Apple, NAS
	local blasvendor="Generic"
	use openblas && blasvendor="OpenBLAS"

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_CXX_COMPILER=hipcc
		-DMAGMA_ENABLE_CUDA=OFF
		-DMAGMA_ENABLE_HIP=ON
		-DUSE_FORTRAN=ON

		-DBLA_VENDOR=${blasvendor}
		-DGPU_TARGET=${gpu}
	)
	#	-DMAGMA_ENABLE_CUDA=$(usex cuda)
	#	-DMAGMA_ENABLE_HIP=$(usex hip)

	#use fortran || mycmakeargs+=( "-DFORTRAN_CONVENTION=-DADD_"
	#use hip && mycmakeargs+=( "-DCMAKE_CXX_COMPILER=hipcc" )
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_install() {
	cmake_src_install
	insinto "/usr/include/${PN}"
	doins include/*.h
	insinto "/usr/$(get_libdir)/pkgconfig"
	doins "${PN}.pc"
	local DOCS=( README ReleaseNotes )
	use doc && local HTML_DOCS=( docs/html/. )
	einstalldocs
}
