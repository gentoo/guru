# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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
	dev-libs/olm
	>=dev-libs/openssl-1.1.0
	dev-libs/spdlog
	>=dev-cpp/coeurl-0.1.0
"
DEPEND="
	${RDEPEND}
	dev-cpp/nlohmann_json
	test? ( dev-cpp/gtest )
"

PATCHES=(
	"${FILESDIR}/0.6.0_remove_network_tests.patch"
)

src_configure() {
	local -a mycmakeargs=(
		-DBUILD_LIB_TESTS="$(usex test)"
		-DBUILD_LIB_EXAMPLES=OFF
	)

	cmake_src_configure
}
