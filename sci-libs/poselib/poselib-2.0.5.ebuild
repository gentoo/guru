# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PN="PoseLib"

DESCRIPTION="Minimal solvers for calibrated camera pose estimation"
HOMEPAGE="https://github.com/PoseLib/PoseLib"
SRC_URI="https://github.com/PoseLib/PoseLib/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="benchmark"

DEPEND="dev-cpp/eigen"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
		-DWITH_BENCHMARK=$(usex benchmark)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	if use benchmark; then
		# As "benchmark" is a too generic name, let's make it more specific.
		mv "${ED}/usr/bin/benchmark" "${ED}/usr/bin/${PN}-benchmark" \
			|| die "Failed to rename benchmark binary"
	fi
}
