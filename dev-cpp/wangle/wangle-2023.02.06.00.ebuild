# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Framework providing common client/server abstractions"
HOMEPAGE="https://github.com/facebook/wangle"
SRC_URI="https://github.com/facebook/wangle/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="examples test"

RDEPEND="
	>=dev-cpp/fizz-${PV}:=
	>=dev-cpp/folly-${PV}:=
	dev-cpp/gflags
	dev-cpp/glog
	dev-libs/double-conversion
	dev-libs/libevent
	dev-libs/libfmt
	dev-libs/openssl:0=
"
DEPEND="
	${RDEPEND}
	dev-cpp/gtest
"

RESTRICT="!test? ( test )"
CMAKE_USE_DIR="${S}/wangle"

src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=$(usex examples)
		-DBUILD_TESTS=$(usex test)
		-DLIB_INSTALL_DIR=$(get_libdir)
	)

	cmake_src_configure
}
