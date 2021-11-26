# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9,10} )

inherit check-reqs cmake flag-o-matic python-single-r1

DESCRIPTION="A fast very high compression read-only FUSE file system"
HOMEPAGE="https://github.com/mhx/dwarfs"
SRC_URI="https://github.com/mhx/dwarfs/releases/download/v${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="python +jemalloc test"

RDEPEND="
	${PYTHON_DEPS}
	app-arch/libarchive
	app-arch/lz4
	app-arch/snappy
	app-arch/xz-utils
	app-arch/zstd
	dev-cpp/fbthrift:=
	>=dev-cpp/folly-2021.04.19.00-r1:=
	dev-cpp/gflags
	dev-cpp/glog[gflags]
	dev-cpp/parallel-hashmap:=
	dev-cpp/sparsehash
	dev-libs/boost[context,threads(+),python?]
	dev-libs/double-conversion
	dev-libs/fsst:=
	dev-libs/libevent
	dev-libs/libfmt
	dev-libs/xxhash
	sys-fs/fuse:3
	sys-libs/binutils-libs
	sys-libs/libunwind
	sys-libs/zlib

	jemalloc? ( >=dev-libs/jemalloc-5.2.1 )
"
DEPEND="
	${RDEPEND}
	sys-devel/flex
"
BDEPEND="
	app-text/ronn
	sys-devel/bison
	virtual/pkgconfig

	test? ( dev-cpp/gtest )
"

DOCS=( "README.md" "CHANGES.md" "TODO" )
RESTRICT="!test? ( test )"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
PATCHES=( "${FILESDIR}/${P}-unbundle.patch" "${FILESDIR}/${P}-mutex.patch" )

CHECKREQS_DISK_BUILD="1300M"
CMAKE_IN_SOURCE_BUILD=1
CMAKE_WARN_UNUSED_CLI=0

src_prepare(){
	rm -r fsst zstd fbthrift/* folly xxHash parallel-hashmap || die
	cmake_src_prepare
	sed "s/DESTINATION lib/DESTINATION $(get_libdir)/" -i CMakeLists.txt || die
}

src_configure(){
	append-cxxflags "-I/usr/include"

	mycmakeargs=(
		-DUSE_JEMALLOC=$(usex jemalloc ON OFF)
		-DWITH_PYTHON=$(usex python ON OFF)
		-DWITH_TESTS=$(usex test ON OFF)
		-DPREFER_SYSTEM_ZSTD=1
		-DPREFER_SYSTEM_XXHASH=1
		-DPREFER_SYSTEM_GTEST=1
		-DWITH_LEGACY_FUSE=0
	)
	use python && mycmakeargs+=( "-DWITH_PYTHON_VERSION=${EPYTHON#python}" )
	cmake_src_configure
}

src_install(){
	cmake_src_install
	dolib.so libdwarfs.so
}

pkg_postinst(){
	elog "Suggest to enable USE 'threads' globally if you have multicore machine"
	elog "Since version 0.4.1 GGC builds has been fixed. Now both Clang and GCC are working very well"
	elog "You may find more information in the"
	elog "${HOMEPAGE}"
	elog "About creating: ${HOMEPAGE}/blob/main/doc/mkdwarfs.md"
	elog "About mounting: ${HOMEPAGE}/blob/main/doc/dwarfs.md"
}
