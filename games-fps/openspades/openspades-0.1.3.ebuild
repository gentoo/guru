# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg flag-o-matic

PAK_REV=33

DESCRIPTION="Open-source voxel FPS"
HOMEPAGE="https://openspades.yvt.jp/"
SRC_URI="
https://github.com/yvt/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
https://github.com/yvt/${PN}-paks/releases/download/r${PAK_REV}/OpenSpadesDevPackage-r${PAK_REV}.zip
"
# GPL-2 refers to the bundled Unifont.
LICENSE="GPL-3 GPL-2-with-font-exception OFL-1.1 openspades-pak"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"
RDEPEND="
media-libs/libsdl2
media-libs/sdl2-image[jpeg,png]
media-libs/glew
net-misc/curl
media-libs/freetype
media-libs/opus
media-libs/opusfile
x11-misc/xdg-utils
x11-themes/hicolor-icon-theme
"
DEPEND="${RDEPEND}"
BDEPEND="
virtual/pkgconfig
app-arch/zip
app-arch/unzip
virtual/imagemagick-tools[jpeg,png]
"
PATCHES=(
	"${FILESDIR}/${PN}-0.1.3-dont-compress-docs.patch"
)
CMAKE_BUILD_TYPE=release

src_prepare() {
	cmake_src_prepare

	mkdir -p "${BUILD_DIR}/Resources"
	mv "${WORKDIR}/Nonfree/pak000-Nonfree.pak" "${BUILD_DIR}/Resources/"
	mv "${WORKDIR}/Nonfree/LICENSE.md" "${BUILD_DIR}/Resources/LICENSE.pak000.md"
	mv "${WORKDIR}/OfficialMods/font-unifont.pak" "${BUILD_DIR}/Resources/"
	mv "${WORKDIR}/OfficialMods/LICENSE" "${BUILD_DIR}/Resources/LICENSE.unifont.txt"

	# Without this, CMake will error out because it will try to download the zip
	# during building.
	touch "${BUILD_DIR}/Resources/OpenSpadesDevPackage-r${PAK_REV}.zip"

	append-cflags -fno-strict-aliasing
	append-cxxflags -fno-strict-aliasing
}

src_configure() {
	local mycmakeargs=(
		-DOPENSPADES_INSTALL_DOC=share/doc/"${PF}"
		-DOPENSPADES_INSTALL_BINARY=bin
		-DOPENSPADES_INSTALL_RESOURCES=share/"${PN}"/Resources
		# This arg is currently unused, but I'll set it anyway just in case it's
		# needed in a later version.
		-DOPENSPADES_INSTALL_LIBS=$(get_libdir)
	)

	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
