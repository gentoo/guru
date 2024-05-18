# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ logging library"
HOMEPAGE="https://github.com/abumq/easyloggingpp"
SRC_URI="https://github.com/abumq/easyloggingpp/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="test? ( dev-cpp/gtest )"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/disable-failing-tests.patch"
)

src_configure() {
	local mycmakeargs+=(
		-Dtest=$(usex test ON OFF)
	)
	cmake_src_configure
}
