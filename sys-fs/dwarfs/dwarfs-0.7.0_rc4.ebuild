# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit check-reqs cmake flag-o-matic python-single-r1

MY_PV="${PV/_rc/-RC}"

DESCRIPTION="A fast very high compression read-only FUSE file system"
HOMEPAGE="https://github.com/mhx/dwarfs"
SRC_URI="https://github.com/mhx/dwarfs/releases/download/v${MY_PV}/${PN}-${MY_PV}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="python +jemalloc test man"
S="${WORKDIR}/dwarfs-${MY_PV}"

PATCHES=(
	"${FILESDIR}/dwarfs-0.7.0_rc4-stdexcept.patch"
	"${FILESDIR}/dwarfs-0.7.0_rc4-fbthrift-cstdint.patch"
)

RDEPEND="
	${PYTHON_DEPS}
	app-arch/libarchive
	app-arch/lz4
	app-arch/snappy
	app-arch/xz-utils
	app-arch/zstd
	dev-cpp/gflags
	dev-cpp/glog[gflags]
	dev-cpp/parallel-hashmap:=
	dev-libs/boost[context,python?]
	dev-libs/double-conversion
	dev-libs/libevent
	dev-libs/libfmt
	dev-libs/xxhash
	sys-fs/fuse:3
	dev-libs/fsst
	sys-libs/binutils-libs
	sys-libs/libunwind
	sys-libs/zlib
	!dev-cpp/fbthrift
	!dev-cpp/fizz
	!dev-cpp/folly
	!dev-cpp/wangle
	jemalloc? ( >=dev-libs/jemalloc-5.3.0-r1 )
"

DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/patchelf
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
	man? ( app-text/ronn-ng )
	test? ( dev-cpp/gtest )
"

DOCS=( "README.md" "CHANGES.md" "TODO" )
RESTRICT="!test? ( test )"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

CHECKREQS_DISK_BUILD="1300M"
CMAKE_IN_SOURCE_BUILD=1
CMAKE_WARN_UNUSED_CLI=0

src_prepare(){
	rm -r zstd xxHash parallel-hashmap || die
	cmake_src_prepare
	sed "s/DESTINATION lib/DESTINATION $(get_libdir)/" -i CMakeLists.txt || die
}

src_configure(){
	append-cxxflags "-I/usr/include"

	mycmakeargs=(
		-DUSE_JEMALLOC=$(usex jemalloc ON OFF)
		-DWITH_PYTHON=$(usex python ON OFF)
		-DWITH_TESTS=$(usex test ON OFF)
		-DWITH_MAN_PAGES=$(usex man ON OFF)
		-DPREFER_SYSTEM_ZSTD=ON
		-DPREFER_SYSTEM_XXHASH=ON
		-DPREFER_SYSTEM_GTEST=ON
		-DPREFER_SYSTEM_LIBFMT=ON
		-DWITH_LEGACY_FUSE=OFF
	)
	use python && mycmakeargs+=( "-DWITH_PYTHON_VERSION=${EPYTHON#python}" )
	cmake_src_configure
}

src_install(){
	cmake_src_install
	# Remove insecure RPATH from bundled lib
	patchelf --remove-rpath libdwarfs.so || die
	patchelf --remove-rpath libdwarfs_tool.so || die

	dolib.so libdwarfs.so libdwarfs_tool.so libdwarfs_compression.so libthrift_light.so libmetadata_thrift.so
	dolib.so folly/libfolly.so folly/libfolly.so.0.58.0-dev
}

pkg_postinst(){
	elog "You may find more information in the"
	elog "${HOMEPAGE}"
	elog "About creating: ${HOMEPAGE}/blob/main/doc/mkdwarfs.md"
	elog "About mounting: ${HOMEPAGE}/blob/main/doc/dwarfs.md"
}
