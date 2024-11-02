# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs cmake flag-o-matic

DESCRIPTION="A fast high compression read-only file system for Linux, Windows and macOS"
HOMEPAGE="https://github.com/mhx/dwarfs"
SRC_URI="https://github.com/mhx/dwarfs/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+jemalloc test +tools +fuse +perfmon flac ricepp stacktrace"
S="${WORKDIR}/dwarfs-${PV}"

PATCHES=(
	"${FILESDIR}"/dwarfs-libfmt9.patch
)

RDEPEND="
	>=app-arch/libarchive-3.6.0
	>=app-arch/brotli-1.0.9
	>=app-arch/lz4-1.9.3
	>=app-arch/xz-utils-5.2.5
	>=app-arch/zstd-1.4.8
	dev-cpp/gflags
	dev-cpp/glog[gflags]
	>=dev-cpp/parallel-hashmap-1.3.8
	dev-libs/boost[context]
	dev-libs/double-conversion
	dev-libs/libevent
	>=dev-libs/libfmt-9.1.0
	dev-libs/utfcpp
	>=dev-libs/xxhash-0.8.1
	flac? ( >=media-libs/flac-1.4.2 )
	fuse? ( sys-fs/fuse:3 )
	sys-libs/binutils-libs
	stacktrace? ( sys-libs/libunwind )
	sys-libs/zlib
	jemalloc? ( >=dev-libs/jemalloc-5.2.1 )
	test? ( >=dev-cpp/gtest-1.13.0 )
	>=dev-cpp/range-v3-0.12.0
	dev-libs/date
	dev-cpp/nlohmann_json
"

DEPEND="
	${RDEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

FEATURES="
	stacktrace? ( nostrip )
"

DOCS=( "README.md" "CHANGES.md" "TODO" )
RESTRICT="!test? ( test )"

CHECKREQS_DISK_BUILD="500M"
CMAKE_WARN_UNUSED_CLI=0

src_prepare(){
	cmake_src_prepare
	sed "s/DESTINATION lib/DESTINATION $(get_libdir)/" -i cmake/libdwarfs.cmake || die
}

src_configure(){
	mycmakeargs=(
		-DUSE_JEMALLOC=$(usex jemalloc ON OFF)
		-DWITH_TESTS=$(usex test ON OFF)
		-DWITH_MAN_PAGES=ON
		-DWITH_MAN_OPTION=ON
		-DWITH_LIBDWARFS=ON
		-DWITH_TOOLS=$(usex tools ON OFF)
		-DWITH_FUSE_DRIVER=$(usex fuse ON OFF)
		-DENABLE_PERFMON=$(usex perfmon ON OFF)
		-DTRY_ENABLE_FLAC=$(usex flac ON OFF)
		-DENABLE_RICEPP=$(usex ricepp ON OFF)
		-DENABLE_STACKTRACE=$(usex stacktrace ON OFF)
		-DWITH_LEGACY_FUSE=OFF
		-DPREFER_SYSTEM_GTEST=ON
	)
	cmake_src_configure
}

src_test(){
	export DWARFS_SKIP_FUSE_TESTS=1
	local CMAKE_SKIP_TESTS=(
		# Perfmon is not working within sandbox
		dwarfsextract_test.perfmon
	)

	cmake_src_test
}

pkg_postinst(){
	elog "More information: ${HOMEPAGE}"
	if use tools ; then
			elog " creating images: mkdwarfs --man"
			elog " creating images: man mkdwarfs"
			elog " creating images: ${HOMEPAGE}/blob/main/doc/mkdwarfs.md"
	fi
	if use fuse ; then
			elog " mounting images: dwarfs --man"
			elog " mounting images: man dwarfs"
			elog " mounting images: ${HOMEPAGE}/blob/main/doc/dwarfs.md"
	fi
}
