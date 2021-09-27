# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Client API library for Matrix, built on top of Boost.Asio"
HOMEPAGE="https://github.com/Nheko-Reborn/mtxclient"
SRC_URI="https://github.com/Nheko-Reborn/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-libs/boost-1.70.0
	<dev-libs/olm-3.2.5
	>=dev-libs/openssl-1.1.0
	dev-cpp/nlohmann_json
"
DEPEND="
	${RDEPEND}
	dev-libs/spdlog
	test? ( dev-cpp/gtest )
"

# remove_failing_tests depends on remove_network_tests.
PATCHES=(
	"${FILESDIR}/0.3.0_remove_network_tests.patch"
	"${FILESDIR}/0.3.0_remove_failing_tests.patch"
)

src_configure() {
	local -a mycmakeargs=(
		-DBUILD_LIB_TESTS="$(usex test)"
		-DBUILD_LIB_EXAMPLES=OFF
	)

	cmake_src_configure
}
