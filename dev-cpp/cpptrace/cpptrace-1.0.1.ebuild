# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Simple, portable, and self-contained stacktrace library for C++"
HOMEPAGE="https://github.com/jeremy-rifkin/cpptrace"
SRC_URI="https://github.com/jeremy-rifkin/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/libdwarf
	test? ( dev-cpp/gtest )"
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED="unittest"

src_configure() {
	local mycmakeargs=(
		-DCPPTRACE_USE_EXTERNAL_LIBDWARF=On
		-DCPPTRACE_USE_EXTERNAL_GTEST=On
		-DCPPTRACE_BUILD_TESTING=$(usex test)
	)

	cmake_src_configure
}
