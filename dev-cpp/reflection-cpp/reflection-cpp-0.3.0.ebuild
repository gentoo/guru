# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Boxing primitive types in C++"
HOMEPAGE="https://github.com/contour-terminal/reflection-cpp"
SRC_URI="https://github.com/contour-terminal/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	test? (
		dev-cpp/catch:0
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DREFLECTION_TESTING=$(usex test)
	)

	cmake_src_configure
}
