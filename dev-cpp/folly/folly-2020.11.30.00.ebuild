# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="An open-source C++ library developed and used at Facebook"
HOMEPAGE="https://github.com/facebook/folly"

SRC_URI="https://github.com/facebook/folly/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~x86"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="static-libs"

DEPEND="app-arch/lz4
		app-arch/snappy
		app-arch/xz-utils
		app-arch/zstd
		dev-libs/double-conversion
		dev-libs/libevent
		dev-libs/openssl
		dev-cpp/gflags
		dev-cpp/glog[gflags]
		dev-libs/boost[context,threads]
		sys-libs/binutils-libs
		sys-libs/zlib
		sys-devel/binutils:*"
RDEPEND="${DEPEND}"
