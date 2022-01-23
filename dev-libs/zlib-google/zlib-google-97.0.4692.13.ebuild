# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="google zlib extras"
HOMEPAGE="https://chromium.googlesource.com/chromium/src/+/refs/heads/main/third_party/zlib/google"
SRC_URI="https://chromium.googlesource.com/chromium/src/+archive/refs/tags/${PV}/third_party/zlib.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}"

src_compile() {
	cd google || die

	tc-export CXX

	${CXX} \
		${CXXFLAGS} \
		${LDFLAGS} \
		-DUSE_SYSTEM_ZLIB \
		-fPIC \
		-shared \
		-I. \
		-Wl,-soname,libzlib_compression_utils_portable.so \
		compression_utils_portable.cc \
		-o libzlib_compression_utils_portable.so \
		-lz \
		|| die
}

src_install() {
	cd google || die
	dolib.so libzlib_compression_utils_portable.so
	doheader compression_utils_portable.h
}
