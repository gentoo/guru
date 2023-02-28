# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )

inherit check-reqs cmake flag-o-matic python-single-r1

MY_P="${P/_rc/-RC}"

DESCRIPTION="A fast very high compression read-only FUSE file system"
HOMEPAGE="https://github.com/mhx/dwarfs"
SRC_URI="https://github.com/mhx/dwarfs/releases/download/v0.7.0-RC4/dwarfs-0.7.0-RC4.tar.xz" #TODO: change to ${PV}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="python +jemalloc test man +bundled-libs"
S="${WORKDIR}/${MY_P}"

RDEPEND="
	${PYTHON_DEPS}
	app-arch/libarchive
	app-arch/lz4
	app-arch/snappy
	app-arch/xz-utils
	app-arch/zstd
	dev-cpp/fbthrift:=
	dev-cpp/folly:=
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

	jemalloc? ( >=dev-libs/jemalloc-5.3.0-r1 )
"
DEPEND="
	${RDEPEND}
	sys-devel/flex
	!sys-fs/dwarfs-bin
"
BDEPEND="
	man? ( || ( app-text/ronn app-text/ronn-ng ) )
	sys-devel/bison
	virtual/pkgconfig

	test? ( dev-cpp/gtest )
"

DOCS=( "README.md" "CHANGES.md" "TODO" )
RESTRICT="!test? ( test )"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
PATCHES=( "${FILESDIR}/${P}-unbundle.patch" )

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
		-WITH_MAN_PAGES=$(usex man ON OFF)
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
	elog "You may find more information in the"
	elog "${HOMEPAGE}"
	elog "About creating: ${HOMEPAGE}/blob/main/doc/mkdwarfs.md"
	elog "About mounting: ${HOMEPAGE}/blob/main/doc/dwarfs.md"
}
