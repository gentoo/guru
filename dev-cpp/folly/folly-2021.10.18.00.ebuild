# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="An open-source C++ library developed and used at Facebook"
HOMEPAGE="https://github.com/facebook/folly"
SRC_URI="https://github.com/facebook/folly/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="
	app-arch/lz4
	<app-arch/snappy-1.1.9
	app-arch/zstd
	dev-cpp/gflags
	dev-cpp/glog[gflags]
	dev-libs/boost[context,threads(+)]
	dev-libs/double-conversion
	dev-libs/libevent
	dev-libs/libfmt
	sys-libs/binutils-libs
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake_src_prepare
	sed \
		-e "s/lib CACHE/$(get_libdir) CACHE/" \
		-e "s/lib\/cmake\/folly CACHE/$(get_libdir)\/cmake\/folly CACHE/" \
		-i CMakeLists.txt || die
}
