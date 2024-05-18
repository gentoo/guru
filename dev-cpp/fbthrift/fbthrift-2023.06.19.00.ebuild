# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit cmake python-single-r1

DESCRIPTION="Facebook's branch of Apache Thrift, including a new C++ server"
HOMEPAGE="https://github.com/facebook/fbthrift"
SRC_URI="https://github.com/facebook/fbthrift/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	app-arch/zstd
	>=dev-cpp/fizz-${PV}:=
	>=dev-cpp/folly-${PV}:=
	dev-cpp/gflags
	dev-cpp/glog
	>=dev-cpp/wangle-${PV}:=
	dev-libs/boost
	dev-libs/libfmt
	dev-libs/openssl:0=
	sys-libs/zlib
	${PYTHON_DEPS}
"
DEPEND="
	${RDEPEND}
	$(python_gen_cond_dep 'dev-python/six[${PYTHON_USEDEP}]')
"
BDEPEND="
	sys-devel/bison
	sys-devel/flex
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR=$(get_libdir)
	)
	cmake_src_configure
}
