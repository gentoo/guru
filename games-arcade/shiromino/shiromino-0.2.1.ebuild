# Copyright 2023 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="fast-paced puzzle game with roots in the arcade"
HOMEPAGE="https://github.com/shiromino/shiromino"
MY_PDBM_COMMIT="f16abc76419f2df31c8c3f0642bedaad99201cda"
SRC_URI="
	https://github.com/shiromino/shiromino/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/nightmareci/PDBMFont/archive/${MY_PDBM_COMMIT}.tar.gz -> PDBMFont-${MY_PDBM_COMMIT}.tar.gz
"
PDBMFont_S="${WORKDIR}/PDBMFont-${MY_PDBM_COMMIT}/"

# Main under MIT, music under CC-BY-4.0, font under Unlicense
LICENSE="MIT CC-BY-4.0 Unlicense"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="virtual/pkgconfig"

RDEPEND="
	media-libs/libvorbis
	media-libs/libsdl2
	media-libs/sdl2-image
	media-libs/sdl2-mixer
	dev-db/sqlite:3
	dev-libs/tinyxml2:=
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/shiromino-0.2.1-fix_cmake_targets.patch" )

src_prepare() {
	cmake_src_prepare

	rm "${PDBMFont_S}/tinyxml2.cpp" "${PDBMFont_S}/tinyxml2.h" || die

	sed -i -e 's;#include "tinyxml2.h";#include <tinyxml2.h>;' "${PDBMFont_S}/PDBMFont.hpp" || die

	sed -i \
		-e '/tinyxml2\./d' \
		-e '/MINIMUM_SDL2_VERSION/iset(MINIMUM_TINYXML2_VERSION 0)' \
		-e '/set(DEPENDENCIES/a		tinyxml2' \
		CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		-DFETCHCONTENT_SOURCE_DIR_PDBM_FONT="${PDBMFont_S}"
	)

	cmake_src_configure
}
