# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake

DESCRIPTION="Performance-portable, length-agnostic SIMD with runtime dispatch"
HOMEPAGE="https://github.com/google/highway"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/google/highway.git"
else
	SRC_URI="https://github.com/google/highway/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""

BDEPEND=""

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
	)

	cmake_src_configure
}
