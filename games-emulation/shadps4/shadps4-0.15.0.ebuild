# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="An early PlayStation 4 emulator for Windows, Linux and macOS written in C++"

HOMEPAGE="https://github.com/shadps4-emu/shadPS4"

LLVM_COMPAT=( {19..21} )
inherit llvm-r2

if [ ${PV} = 9999 ]; then
	EGIT_BRANCH="main"
else
	EGIT_COMMIT="v.${PVR}"
fi

EGIT_REPO_URI="https://github.com/shadps4-emu/shadPS4.git"
EGIT_SUBMODULES=( '*' )

LICENSE="GPL-2"

SLOT="0"

BDEPEND="virtual/pkgconfig
		$(llvm_gen_dep '
		llvm-core/clang:${LLVM_SLOT}=
		llvm-core/llvm:${LLVM_SLOT}=
		')
		sys-devel/mold
		dev-util/ccache
		"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=mold" -DCMAKE_SHARED_LINKER_FLAGS="-fuse-ld=mold"
		-DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache
	)
	cmake_src_configure
}
