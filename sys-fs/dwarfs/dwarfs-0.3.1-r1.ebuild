# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit cmake check-reqs python-single-r1

DESCRIPTION="A fast very high compression read-only FUSE file system"
HOMEPAGE="https://github.com/mhx/dwarfs"

SRC_URI="https://github.com/mhx/dwarfs/releases/download/v${PV}/dwarfs-${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="python +jemalloc"

#test IUSE disabled because there is no googletest in portage tree
#-DWITH_TESTS=$(usex test ON OFF)

PYTHON_REQ_USE="python"

DEPEND="sys-devel/flex
		sys-devel/binutils:*"
RDEPEND="dev-libs/boost[context,threads,python?]
		dev-libs/double-conversion
		dev-libs/libfmt
		dev-libs/libevent
		dev-libs/xxhash
		jemalloc? ( >=dev-libs/jemalloc-5.2.1 )
		app-arch/zstd
		app-arch/lz4
		app-arch/xz-utils
		app-arch/snappy
		dev-cpp/sparsehash
		dev-cpp/gflags
		dev-cpp/glog[gflags]
		sys-fs/fuse:3
		sys-libs/binutils-libs
		sys-libs/zlib
		sys-libs/libunwind
		!dev-cpp/folly"
BDEPEND="app-text/ronn
		dev-util/cmake
		sys-apps/sed
		sys-devel/bison
		virtual/pkgconfig"

CHECKREQS_DISK_BUILD="768M"

DOCS=( "README.md" "CHANGES.md" "TODO" )

CMAKE_IN_SOURCE_BUILD=true
CMAKE_WARN_UNUSED_CLI=no

QA_SONAME="${D}/usr/lib64/libdwarfs.so ${D}/usr/lib64/libxxhash.so"

src_prepare(){
	einfo "setting library path to $(get_libdir)"
	sed "s/DESTINATION lib/DESTINATION $(get_libdir)/" -i CMakeLists.txt || die
	cmake_src_prepare
}

src_configure(){
	einfo "setting configuration flags to:"
	mycmakeargs=(
		-DUSE_JEMALLOC=$(usex jemalloc ON OFF)
		-DWITH_PYTHON=$(usex python ON OFF)
	)
	if use python; then mycmakeargs+=( -DWITH_PYTHON_VERSION=${EPYTHON#python} ); fi
	einfo ${mycmakeargs}
	cmake_src_configure
}

src_install(){
	cmake_src_install
	dolib.so libmetadata_thrift.so libthrift_light.so
	dolib.so folly/libfolly.so.0.58.0-dev folly/libfolly.so
}

pkg_postinst(){
	elog "Test shows that dwarfs compiled with Clang is substantially faster than GCC ones"
	elog "See https://github.com/mhx/dwarfs/issues/14"
	elog "So you may want to compile it independently with Clang by the"
	elog "https://wiki.gentoo.org/wiki/Clang"
	elog "And with the per-package settings:"
	elog "https://wiki.gentoo.org/wiki/Handbook:AMD64/Portage/Advanced#Per-package_environment_variables"
	elog "Also you may find more information in the"
	elog "${HOMEPAGE}"
	elog "About creating: ${HOMEPAGE}/blob/main/doc/mkdwarfs.md"
	elog "About mounting: ${HOMEPAGE}/blob/main/doc/dwarfs.md"
	ewarn "If you have both sys-fs/fuse:2 and sys-fs/fuse:3 installed"
	ewarn "Dwarfs will install /sbin/dwarfs for fuse3 and /sbin/dwarfs2 for fuse2"
	ewarn "See https://github.com/mhx/dwarfs/issues/32"
}
