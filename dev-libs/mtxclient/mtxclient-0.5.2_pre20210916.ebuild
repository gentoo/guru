# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_COMMIT="b452a984b0fc522c21bb8df7d320bf13960974d0"
DESCRIPTION="Client API library for Matrix, built on top of Boost.Asio"
HOMEPAGE="https://github.com/Nheko-Reborn/mtxclient"
SRC_URI="https://github.com/Nheko-Reborn/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-libs/boost-1.70.0
	dev-libs/olm
	>=dev-libs/openssl-1.1.0
	dev-cpp/nlohmann_json
	dev-libs/spdlog
	dev-cpp/coeurl
"
DEPEND="
	${RDEPEND}
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
