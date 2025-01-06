# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Read-only FUSE file system for mounting archives and compressed files"
HOMEPAGE="https://github.com/google/fuse-archive"

# Only uses some header-only library from boost-intrusive
# Just vendor it to avoid bringing in entirety of boost as a dependency
BOOST_VERSION="boost-1.87.0"
SRC_URI="
	https://github.com/google/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/boostorg/intrusive/archive/refs/tags/${BOOST_VERSION}.tar.gz -> intrusive-${BOOST_VERSION}.tar.gz
	https://github.com/boostorg/config/archive/refs/tags/${BOOST_VERSION}.tar.gz -> config-${BOOST_VERSION}.tar.gz
	https://github.com/boostorg/assert/archive/refs/tags/${BOOST_VERSION}.tar.gz -> assert-${BOOST_VERSION}.tar.gz
	https://github.com/boostorg/move/archive/refs/tags/${BOOST_VERSION}.tar.gz -> move-${BOOST_VERSION}.tar.gz
"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	sys-fs/fuse:0
	app-arch/libarchive
"
BDEPEND="virtual/pkgconfig"
RDEPEND="${DEPEND}"

# TODO(NRK): enable tests. requires python.
# also takes a lot of disk space (and time) by generating big.zip.
src_test() {
	:
}

src_compile() {
	local incpath=""
	incpath="${incpath} -I../intrusive-${BOOST_VERSION}/include"
	incpath="${incpath} -I../config-${BOOST_VERSION}/include"
	incpath="${incpath} -I../assert-${BOOST_VERSION}/include"
	incpath="${incpath} -I../move-${BOOST_VERSION}/include"
	emake CXX="$(tc-getCXX)" PKG_CONFIG="$(tc-getPKG_CONFIG)" \
		CPPFLAGS="${incpath} ${CPPFLAGS}"
}

src_install() {
	dobin out/fuse-archive
	doman fuse-archive.1
}
