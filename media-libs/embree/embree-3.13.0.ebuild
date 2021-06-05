# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake flag-o-matic linux-info toolchain-funcs

DESCRIPTION="Collection of high-performance ray tracing kernels"
HOMEPAGE="https://github.com/embree/embree"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 -*"
SRC_URI="https://github.com/embree/embree/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SLOT="3"
ARM_CPU_FLAGS=( neon:neon )
X86_CPU_FLAGS=( sse2:sse2 sse4_2:sse4_2 avx:avx avx2:avx2 avx512dq:avx512dq )
CPU_FLAGS=( ${ARM_CPU_FLAGS[@]/#/cpu_flags_arm_} ${X86_CPU_FLAGS[@]/#/cpu_flags_x86_} )
IUSE="+compact-polys ispc raymask ssp static-libs +tbb tutorial ${CPU_FLAGS[@]%:*}"

BDEPEND="
	virtual/pkgconfig
"
RDEPEND="
	amd64? ( ispc? ( dev-lang/ispc ) )
	x86? ( ispc? ( dev-lang/ispc ) )
	media-libs/glfw
	tbb? ( dev-cpp/tbb )
	tutorial? (
		media-libs/libpng:0=
		media-libs/openimageio
		virtual/jpeg:0
	)
	virtual/opengl
"
DEPEND="${RDEPEND}"
REQUIRED_USE="
	arm? ( !ispc )
	arm64? ( !ispc )"

DOCS=( CHANGELOG.md README.md readme.pdf )
CMAKE_BUILD_TYPE=Release

pkg_setup() {
	CONFIG_CHECK="~TRANSPARENT_HUGEPAGE"
	WARNING_TRANSPARENT_HUGEPAGE="Not enabling Transparent Hugepages (CONFIG_TRANSPARENT_HUGEPAGE) will impact rendering performance."
	linux-info_pkg_setup
}

src_prepare() {
	cmake_src_prepare

	# disable RPM package building
	sed -e 's|CPACK_RPM_PACKAGE_RELEASE 1|CPACK_RPM_PACKAGE_RELEASE 0|' \
		-i CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
		-DCMAKE_SKIP_INSTALL_RPATH=ON
		-DEMBREE_IGNORE_CMAKE_CXX_FLAGS=OFF
		-DEMBREE_BACKFACE_CULLING=OFF			# default
		-DEMBREE_FILTER_FUNCTION=ON			# default
		-DEMBREE_GEOMETRY_CURVE=ON			# default
		-DEMBREE_GEOMETRY_GRID=ON			# default
		-DEMBREE_GEOMETRY_INSTANCE=ON			# default
		-DEMBREE_GEOMETRY_POINT=ON			# default
		-DEMBREE_GEOMETRY_QUAD=ON			# default
		-DEMBREE_GEOMETRY_SUBDIVISION=ON		# default
		-DEMBREE_GEOMETRY_TRIANGLE=ON			# default
		-DEMBREE_GEOMETRY_USER=ON			# default
		-DEMBREE_IGNORE_INVALID_RAYS=OFF		# default
		-DEMBREE_ISPC_SUPPORT=$(usex ispc)
		-DEMBREE_RAY_MASK=$(usex raymask)
		-DEMBREE_RAY_PACKETS=ON				# default
		-DEMBREE_STACK_PROTECTOR=$(usex ssp)
		-DEMBREE_STATIC_LIB=$(usex static-libs)
		-DEMBREE_COMPACT_POLYS=$(usex compact-polys)
		-DEMBREE_STAT_COUNTERS=OFF
		-DEMBREE_TASKING_SYSTEM=$(usex tbb "TBB" "INTERNAL")
		-DEMBREE_TUTORIALS=$(usex tutorial) )

	if use tutorial; then
		mycmakeargs+=(
			-DEMBREE_ISPC_ADDRESSING=64
			-DEMBREE_TUTORIALS_LIBJPEG=ON
			-DEMBREE_TUTORIALS_LIBPNG=ON
			-DEMBREE_TUTORIALS_OPENIMAGEIO=ON
		)
	fi

	# Set supported ISA
	mycmakeargs+=(
		-DEMBREE_MAX_ISA=NONE
		-DEMBREE_ISA_NEON=$(usex cpu_flags_arm_neon)
		-DEMBREE_ISA_AVX512=$(usex cpu_flags_x86_avx512dq)
		-DEMBREE_ISA_AVX2=$(usex cpu_flags_x86_avx2)
		-DEMBREE_ISA_AVX=$(usex cpu_flags_x86_avx)
		-DEMBREE_ISA_SSE42=$(usex cpu_flags_x86_sse4_2)
		-DEMBREE_ISA_SSE2=$(usex cpu_flags_x86_sse2)
	)

	tc-export CC CXX

	cmake_src_configure
}

src_install() {
	cmake_src_install

	doenvd "${FILESDIR}"/99${PN}${SLOT}
}
