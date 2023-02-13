# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="FreeSpace2 Source Code Project game engine"
HOMEPAGE="https://github.com/scp-fs2open/fs2open.github.com/"

# Replace "." with "_" in version
_PV=${PV//./_}

# Current hashes of external repositories:
HASH_LIBROCKET="ecd648a43aff8a9f3daf064d75ca5725237d5b38"
HASH_CMAKE_MODULES="7cef9577d6fc35057ea57f46b4986a8a28aeff50"

SRC_URI="
	https://github.com/scp-fs2open/fs2open.github.com/archive/refs/tags/release_${_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/asarium/libRocket/archive/${HASH_LIBROCKET}.tar.gz -> ${P}-ext_libRocket.tar.gz
	https://github.com/asarium/cmake-modules/archive/${HASH_CMAKE_MODULES}.tar.gz -> ${P}-ext_rpavlik-cmake-modules.tar.gz
"

LICENSE="Unlicense MIT Boost-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="clang debug discord"

DEPEND="
	app-arch/lz4
	<dev-lang/lua-5.1.6:5.1
	dev-libs/jansson
	media-libs/freetype:2
	media-libs/glu
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/libsdl2
	media-libs/libtheora
	media-libs/libvorbis
	media-libs/mesa
	media-libs/openal
	media-video/ffmpeg
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/cmake
	clang? ( sys-devel/clang:= )
"
PATCHES=(
	"${FILESDIR}/${P}-dont-build-lz4.patch"
	"${FILESDIR}/${P}-make-arch-independent.patch"
)

CMAKE_BUILD_TYPE=Release

S="${WORKDIR}/fs2open.github.com-release_${_PV}"

src_unpack() {
	unpack ${A}
	mv libRocket-${HASH_LIBROCKET}/* "${S}/lib/libRocket/" || die
	mv cmake-modules-${HASH_CMAKE_MODULES}/* "${S}/cmake/external/rpavlik-cmake-modules/" || die
}

src_configure() {
	if use clang ; then
		# Force clang
		einfo "Enforcing the use of clang due to USE=clang ..."
		AR=llvm-ar
		CC=${CHOST}-clang
		CXX=${CHOST}-clang++
		LDFLAGS+=" -fuse-ld=lld"
	fi
	cmake_src_configure
}

src_prepare() {
	use discord || eapply "${FILESDIR}/${P}-disable-discord.patch"
	eapply_user
	cmake_src_prepare
	use debug && CMAKE_BUILD_TYPE=Debug
}

src_install() {
	exeinto "/opt/${PN}"
	if use debug ; then
		doexe "${BUILD_DIR}/bin/${PN}_${_PV}-DEBUG"
	else
		doexe "${BUILD_DIR}/bin/${PN}_${_PV}"
	fi
	insinto "/opt/${PN}"
	doins "${BUILD_DIR}/bin/libRocketControls.so"
	doins "${BUILD_DIR}/bin/libRocketControlsLua.so"
	doins "${BUILD_DIR}/bin/libRocketCore.so"
	doins "${BUILD_DIR}/bin/libRocketCoreLua.so"
	doins "${BUILD_DIR}/bin/libRocketDebugger.so"
	use discord && doins "${BUILD_DIR}/bin/libdiscord-rpc.so"
}

pkg_postinst() {
	einfo "This package only generates the engine binary."
	einfo "The retail Freespace 2 data is required to play the"
	einfo "original game and most mods."
}
