# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic optfeature

DESCRIPTION="Read-only FUSE file system for mounting archives and compressed files"
HOMEPAGE="https://github.com/google/fuse-archive"

# Only uses some header-only library from boost
# Just vendor it to avoid bringing in entirety of boost as a dependency
BOOST_VERSION="boost-1.91.0"
SRC_URI="
	https://github.com/google/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/boostorg/intrusive/archive/refs/tags/${BOOST_VERSION}.tar.gz -> intrusive-${BOOST_VERSION}.tar.gz
	https://github.com/boostorg/config/archive/refs/tags/${BOOST_VERSION}.tar.gz -> config-${BOOST_VERSION}.tar.gz
	https://github.com/boostorg/assert/archive/refs/tags/${BOOST_VERSION}.tar.gz -> assert-${BOOST_VERSION}.tar.gz
	https://github.com/boostorg/move/archive/refs/tags/${BOOST_VERSION}.tar.gz -> move-${BOOST_VERSION}.tar.gz
	https://github.com/boostorg/container_hash/archive/refs/tags/${BOOST_VERSION}.tar.gz ->
		container_hash-${BOOST_VERSION}.tar.gz
	https://github.com/boostorg/describe/archive/refs/tags/${BOOST_VERSION}.tar.gz -> describe-${BOOST_VERSION}.tar.gz
	https://github.com/boostorg/mp11/archive/refs/tags/${BOOST_VERSION}.tar.gz -> mp11-${BOOST_VERSION}.tar.gz
"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="fuse2"

DEPEND="
	fuse2? ( >=sys-fs/fuse-2.9:0 )
	!fuse2? ( >=sys-fs/fuse-3.1:3 )
	>=app-arch/libarchive-3.7
"
BDEPEND="virtual/pkgconfig"
RDEPEND="${DEPEND}"
# TODO(NRK): enable tests. requires python.
# use the "fast" test which skips creating large files.
RESTRICT="test"

src_configure() {
	sed -i 's|-O2||g' Makefile || die "sed failed"
	sed -i 's|-O0 -g||g' Makefile || die "sed failed"
}

src_compile() {
	append-cppflags "-I../intrusive-${BOOST_VERSION}/include"
	append-cppflags "-I../config-${BOOST_VERSION}/include"
	append-cppflags "-I../assert-${BOOST_VERSION}/include"
	append-cppflags "-I../move-${BOOST_VERSION}/include"
	append-cppflags "-I../container_hash-${BOOST_VERSION}/include"
	append-cppflags "-I../describe-${BOOST_VERSION}/include"
	append-cppflags "-I../mp11-${BOOST_VERSION}/include"
	emake CXX="$(tc-getCXX)" PKG_CONFIG="$(tc-getPKG_CONFIG)" \
		FUSE_MAJOR_VERSION="$(usex fuse2 2 3)"
}

src_install() {
	dobin out/fuse-archive
	doman fuse-archive.1
}

pkg_postinst() {
	optfeature "mounting brotli compressed files" "app-arch/brotli"
	optfeature "mounting LZO compressed files" "app-arch/lzop"
	optfeature "mounting compress (.Z) files" "app-arch/ncompress" "app-arch/nix-compress"
	optfeature "mounting gpg encrypted files" "app-crypt/gnupg"
}
