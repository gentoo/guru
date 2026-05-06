# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg-utils

DESCRIPTION="Official launcher for the shadPS4 emulator."

HOMEPAGE="https://github.com/shadps4-emu/shadps4-qtlauncher"

if [ ${PV} = 9999 ]; then
	EGIT_BRANCH="main"
	else
	EGIT_COMMIT="v.${PVR}"
fi

EGIT_REPO_URI="https://github.com/shadps4-emu/shadps4-qtlauncher.git"
EGIT_SUBMODULES=( '*' )
EGIT_CLONE_TYPE="shallow"

LICENSE="GPL-2"

SLOT="0"

DEPEND="dev-qt/qtmultimedia
"

BDEPEND="virtual/pkgconfig
		>=llvm-core/clang-19.0.0"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
