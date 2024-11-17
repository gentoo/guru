# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Simple convenience library for handling properties and signals in C++11"
HOMEPAGE="https://launchpad.net/properties-cpp"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_${PV}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="doc test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/boost
	doc? (
		app-text/doxygen
		media-gfx/graphviz
	)
	test? ( dev-cpp/gtest )
"

PATCHES=(
	"${FILESDIR}/properties-cpp-0.0.2-cmake-patch.patch"
)

src_prepare() {
	use doc || truncate -s0 doc/CMakeLists.txt || die
	use test || truncate -s0 tests/CMakeLists.txt || die

	cmake_src_prepare
}
