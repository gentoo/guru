# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Roaring bitmaps in C (and C++), with SIMD optimizations"
HOMEPAGE="https://roaringbitmap.org/"
SRC_URI="
	https://github.com/RoaringBitmap/CRoaring/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
"

S="${WORKDIR}/CRoaring-${PV}"

LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/22"
KEYWORDS="~amd64"
IUSE="cpu_flags_arm_neon cpu_flags_x86_avx cpu_flags_x86_avx512f test"

RESTRICT="!test? ( test )"

BDEPEND="
	test? ( >=dev-util/cmocka-2.0 )
"

src_configure() {
	local mycmakeargs=(
		# messes with `-march=native` but oh well
		-DROARING_DISABLE_AVX=$(usex cpu_flags_x86_avx OFF ON)
		-DROARING_DISABLE_NEON=$(usex cpu_flags_arm_neon OFF ON)
		-DROARING_DISABLE_AVX512=$(usex cpu_flags_x86_avx512f OFF ON)
		-DBUILD_SHARED_LIBS=ON
		-DROARING_BUILD_STATIC=OFF
		-DENABLE_ROARING_TESTS=$(usex test)
		-DROARING_USE_CPM=OFF
	)

	cmake_src_configure
}
