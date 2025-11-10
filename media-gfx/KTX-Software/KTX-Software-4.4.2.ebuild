# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="KTX (Khronos Texture) Library and Tools"
HOMEPAGE="https://github.com/KhronosGroup/KTX-Software"

LICENSE="Apache-2.0"
SLOT="0"

SRC_URI="https://github.com/KhronosGroup/KTX-Software/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

BDEPEND="
	app-shells/bash
"

PATCHES=(
	"${FILESDIR}/${P}-remove-O3.patch"
)

src_configure() {
	# basisu_kernels_sse.cpp has a #error if any of those are set
	append-cxxflags $(test-flags-CXX -mno-avx)
	append-cxxflags $(test-flags-CXX -mno-avx2)
	append-cxxflags $(test-flags-CXX -mno-avx512f)
	local mycmakeargs=(
		-DKTX_VERSION=${PV}
		-DKTX_FEATURE_TESTS=OFF
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
}
