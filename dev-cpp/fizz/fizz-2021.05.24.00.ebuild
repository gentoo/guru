# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="C++14 implementation of the TLS-1.3 standard"
HOMEPAGE="https://github.com/facebookincubator/fizz"

SRC_URI="https://github.com/facebookincubator/fizz/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

CMAKE_USE_DIR="${S}/fizz"

RDEPEND="
	~dev-cpp/folly-${PV}:=
	dev-cpp/gflags
	dev-cpp/glog
	dev-libs/double-conversion
	dev-libs/libevent
	dev-libs/libfmt
	dev-libs/libsodium
	dev-libs/openssl:0=
"
#TODO: discover if gtest is linked
DEPEND="
	${RDEPEND}
	dev-cpp/gtest
"

src_prepare() {
	cmake_src_prepare
	sed -i '/Sodium/d' fizz/cmake/fizz-config.cmake.in || die
}

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR=$(get_libdir)
	)

	cmake_src_configure
}
