# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
inherit cmake

# Replace "." with "_" in version
_PV=${PV//./_}

DESCRIPTION="FreeSpace2 Source Code Project game engine"
HOMEPAGE="https://github.com/scp-fs2open/fs2open.github.com/"
EGIT_REPO_URI="https://github.com/scp-fs2open/fs2open.github.com.git"
EGIT_COMMIT="release_${_PV}"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS=""

DEPEND="
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/libtheora
	media-libs/libvorbis
	>=dev-lang/lua-5.1.0:*
	media-libs/mesa
	media-libs/openal
	media-libs/libsdl2
	media-libs/glu
	dev-libs/jansson
	app-arch/lz4
"
RDEPEND="${DEPEND}"
BDEPEND=""

CMAKE_BUILD_TYPE=Release

src_prepare() {
	eapply "${FILESDIR}/${P}-make-arch-independent.patch"
	eapply_user
	cmake_src_prepare
}

src_install() {
	exeinto "/opt/${PN}"
	doexe "${BUILD_DIR}/bin/${PN}_${_PV}"
	insinto "/opt/${PN}"
	doins "${BUILD_DIR}/bin/libRocketControls.so"
	doins "${BUILD_DIR}/bin/libRocketControlsLua.so"
	doins "${BUILD_DIR}/bin/libRocketCore.so"
	doins "${BUILD_DIR}/bin/libRocketCoreLua.so"
	doins "${BUILD_DIR}/bin/libRocketDebugger.so"
	doins "${BUILD_DIR}/bin/libdiscord-rpc.so"
}

pkg_postinst() {
	einfo "This package only generates the engine binary."
	einfo "The retail Freespace 2 data is required to play the"
	einfo "original game and most mods."
}
