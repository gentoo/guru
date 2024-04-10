# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="The OpenCilk concurrency platform for parallel programming"
HOMEPAGE="https://opencilk.org/"

SRC_URI="
	https://github.com/OpenCilk/opencilk-project/archive/refs/tags/opencilk/v${PV}.tar.gz -> ${PN}-project-${PV}.tar.gz
	https://github.com/OpenCilk/cheetah/archive/refs/tags/opencilk/v${PV}.tar.gz -> ${PN}-cheetah-${PV}.tar.gz
	https://github.com/OpenCilk/productivity-tools/archive/refs/tags/opencilk/v${PV}.tar.gz -> ${PN}-productivity-tools-${PV}.tar.gz
"

# Since opencilk-project is a fork of LLVM 12, this lists the licenses
# of LLVM 12, while opencilk-project states that it us under "MIT with
# the OpenCilk Addendum", which basically states that you can
# distributed it under the LLVM licences. I am also not sure if OpenCilk
# is able to change the license of LLVM (which source code they use),
# hence this needs more investigation and we only list t he LLVM 12
# licenses, because those definetly are correct.
LICENSE="Apache-2.0-with-LLVM-exceptions UoI-NCSA BSD public-domain rc"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

MY_POSTFIX="${PN}-v${PV}"
S="${WORKDIR}/${PN}-project-${MY_POSTFIX}"
CMAKE_USE_DIR="${S}/llvm"

RDEPEND="
	dev-libs/libxml2
	sys-libs/ncurses:=
	sys-libs/zlib
"

src_prepare() {
	local -A symlinks
	symlinks["${S}/cheetah"]="${WORKDIR}/cheetah-${MY_POSTFIX}"
	symlinks["${S}/cilktools"]="${WORKDIR}/productivity-tools-${MY_POSTFIX}"

	local link target
	for link in "${!symlinks[@]}"; do
		target="${symlinks[${link}]}"
		ln -rs "${target}" "${link}" || die
	done

	cmake_src_prepare
}

src_configure() {
	local libdir=$(get_libdir)
	local mycmakeargs=(
		-DLLVM_ENABLE_PROJECTS="clang;compiler-rt"
		-DLLVM_ENABLE_RUNTIMES="cheetah;cilktools"
		-DLLVM_TARGETS_TO_BUILD=host
		-DLLVM_ENABLE_ASSERTIONS=$(usex debug)
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/opt/${P}"
		-DLLVM_LIBDIR_SUFFIX=${libdir#lib}
		-DBUILD_SHARED_LIBS=OFF
		-DLLVM_HOST_TRIPLE="${CHOST}"
	)
	cmake_src_configure
}

src_compile() {
	# It appears there is a missing dependency declaration in OpenCilk's
	# cmake build where llvm-link not getting build, leading to
	# LLVM_LINK-NOTFOUND spilling into the make/ninja generator
	# files. Ensure that llvm-link is always build.
	cmake_build llvm-link

	cmake_build
}

src_install() {
	cmake_src_install
	# Do not install man pages which may conflict with llvm/clang/etc.
	rm "${ED}/usr/share/man/man1/scan-build.1" || die
}
