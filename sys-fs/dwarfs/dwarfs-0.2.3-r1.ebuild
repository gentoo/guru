# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake check-reqs

DESCRIPTION="A fast very high compression read-only FUSE file system"
HOMEPAGE="https://github.com/mhx/dwarfs"

FBTHRIFT_MAGIC="2020.11.30.00"
FOLLY_MAGIC="2020.11.30.00"

SRC_URI="https://github.com/mhx/dwarfs/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/facebook/fbthrift/archive/v${FBTHRIFT_MAGIC}.tar.gz -> fbthrift-${FBTHRIFT_MAGIC}.tar.gz
		https://github.com/facebook/folly/archive/v${FOLLY_MAGIC}.tar.gz -> folly-${FOLLY_MAGIC}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/zstd
		app-arch/lz4
		app-arch/xz-utils
		app-arch/snappy
		dev-libs/boost[context,threads]
		dev-libs/double-conversion
		dev-libs/libfmt
		dev-libs/libevent
		dev-cpp/gflags
		dev-cpp/glog[gflags]
		dev-cpp/sparsehash
		sys-libs/binutils-libs
		sys-libs/libunwind
		sys-fs/fuse:3
		sys-devel/flex
		sys-devel/binutils:*
		sys-libs/zlib"
RDEPEND="dev-libs/boost[context,threads]
		dev-libs/double-conversion
		app-arch/zstd
		app-arch/lz4
		app-arch/xz-utils
		app-arch/snappy
		sys-fs/fuse:3
		sys-libs/binutils-libs
		sys-libs/libunwind"
BDEPEND="app-text/ronn
		dev-util/cmake
		sys-apps/sed
		sys-devel/bison
		virtual/pkgconfig"

CHECKREQS_DISK_BUILD="512M"

DOCS=( "README.md" "CHANGES.md" "TODO" )

src_unpack(){
	default
	rm -d "${S}"/fbthrift/
	rm -d "${S}"/folly/
	mv "${WORKDIR}/fbthrift-${FBTHRIFT_MAGIC}" "${S}"/fbthrift/
	mv "${WORKDIR}/folly-${FBTHRIFT_MAGIC}" "${S}"/folly/
}

src_prepare(){
	einfo "setting path to $(get_libdir)"
	pushd "${S}"/folly
		sed "s/lib CACHE/$(get_libdir) CACHE/" -i CMakeLists.txt || die
		sed "s/lib\/cmake\/folly CACHE/$(get_libdir)\/cmake\/folly CACHE/" -i CMakeLists.txt || die
	popd
	pushd "${S}"/fbthrift
		sed "s/lib CACHE/$(get_libdir) CACHE/" -i CMakeLists.txt || die
		sed "s/lib\/cmake\/fbthrift CACHE/$(get_libdir)\/cmake\/fbthrift CACHE/" -i CMakeLists.txt || die
	popd
	sed "s/DESTINATION lib/DESTINATION $(get_libdir)/" -i CMakeLists.txt || die
	cmake_src_prepare
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
}
