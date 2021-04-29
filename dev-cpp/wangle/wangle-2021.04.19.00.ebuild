# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Framework providing common client/server abstractions"
HOMEPAGE="https://github.com/facebook/wangle"

SRC_URI="https://github.com/facebook/wangle/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

CMAKE_USE_DIR="${S}/wangle"

DEPEND="
	~dev-cpp/fizz-${PV}:=
	~dev-cpp/folly-${PV}:=
	dev-cpp/gflags
	dev-cpp/glog
	dev-libs/double-conversion
	dev-libs/libevent
	dev-libs/libfmt
	dev-libs/openssl:0=
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR=$(get_libdir)
	)

	cmake_src_configure
}
