# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit check-reqs cmake flag-o-matic python-any-r1

DESCRIPTION="A fast very high compression read-only FUSE file system"
HOMEPAGE="https://github.com/mhx/dwarfs"
SRC_URI="https://github.com/mhx/dwarfs/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+jemalloc test man"
S="${WORKDIR}/dwarfs-${PV}"

RDEPEND="
	app-arch/libarchive
	app-arch/lz4
	app-arch/snappy
	app-arch/xz-utils
	app-arch/zstd
	dev-cpp/gflags
	dev-cpp/glog[gflags]
	dev-cpp/parallel-hashmap:=
	dev-libs/boost[context]
	dev-libs/date
	dev-libs/double-conversion
	dev-libs/libevent
	dev-libs/libfmt
	dev-libs/utfcpp
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
	${PYTHON_DEPS}
	dev-util/patchelf
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
	man? ( app-text/ronn-ng )
	test? ( dev-cpp/gtest )
	$(python_gen_any_dep 'dev-python/mistletoe[${PYTHON_USEDEP}]')
"

DOCS=( "README.md" "CHANGES.md" "TODO" )
RESTRICT="!test? ( test )"

CHECKREQS_DISK_BUILD="1300M"
CMAKE_IN_SOURCE_BUILD=1
CMAKE_WARN_UNUSED_CLI=0

python_check_deps() {
	python_has_version -b "dev-python/mistletoe[${PYTHON_USEDEP}]"
}

src_prepare() {
	rm -r zstd xxHash parallel-hashmap || die
	sed "s/DESTINATION lib/DESTINATION $(get_libdir)/" -i CMakeLists.txt || die

	# Bug #900016, but upstream discourages O3
	sed '/FLAGS_RELEASE/s# -O2 -g##' -i CMakeLists.txt || die
	sed '/CMAKE_CXX_FLAGS_COMMON/s#-g ##' -i folly/CMake/FollyCompilerUnix.cmake || die
	sed '/^\s*-g$/d' -i folly/CMake/FollyCompilerUnix.cmake || die
	replace-flags -O3 -O2

	cmake_src_prepare
}

src_configure() {
	append-cxxflags "-I/usr/include"
	append-ldflags $(no-as-needed)

	# FIXME: Requires dev-cpp/gtest to be built with -fchar8_t or -std=c++20.
	# This is unfortunately too aggressive:
	# append-cxxflags "-fno-char8_t"

	mycmakeargs=(
		-DUSE_JEMALLOC=$(usex jemalloc ON OFF)
		-DWITH_TESTS=$(usex test ON OFF)
		-DWITH_MAN_PAGES=$(usex man ON OFF)
		-DPREFER_SYSTEM_ZSTD=ON
		-DPREFER_SYSTEM_XXHASH=ON
		-DPREFER_SYSTEM_GTEST=ON
		-DPREFER_SYSTEM_LIBFMT=ON
		-DWITH_LEGACY_FUSE=OFF
		-DDISABLE_CCACHE=ON  # Use FEATURES=ccache
	)
	cmake_src_configure
}

src_install() {
	local libs=(
		folly/libfolly.so
		folly/libfolly.so.0.58.0-dev
		libcompression_thrift.so
		libdwarfs.so
		libdwarfs_categorizer.so
		libdwarfs_compression.so
		libdwarfs_compression_metadata.so
		libdwarfs_main.so
		libdwarfs_tool.so
		libdwarfsbench_main.so
		libdwarfsck_main.so
		libdwarfsck_main.so
		libdwarfsextract_main.so
		libdwarfsextract_main.so
		libfeatures_thrift.so
		libhistory_thrift.so
		libmetadata_thrift.so
		libmkdwarfs_main.so
		libthrift_light.so
	)

	cmake_src_install

	for lib in "${libs[@]}"; do
		# TODO: figure out how to remove this with cmake
		patchelf --remove-rpath "$lib" || die
		dolib.so "$lib"
	done
}

src_test() {
	local CMAKE_SKIP_TESTS=(
		# Tests don't work in sandbox
		# fuse: failed to open /dev/fuse: Permission denied
		dwarfs/tools_test
	)
	cmake_src_test
}

pkg_postinst() {
	elog "You may find more information in the"
	elog "${HOMEPAGE}"
	elog "About creating: ${HOMEPAGE}/blob/main/doc/mkdwarfs.md"
	elog "About mounting: ${HOMEPAGE}/blob/main/doc/dwarfs.md"
}
