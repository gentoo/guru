# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils desktop xdg

DESCRIPTION="Opensource 3D CAD viewer and converter"
HOMEPAGE="https://github.com/fougue/mayo"
SRC_URI="https://github.com/fougue/mayo/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=sci-libs/opencascade-7.7.0-r2
	<sci-libs/opencascade-7.8.0
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qttranslations:5
	>=media-libs/assimp-5.3.1
"

DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-nogit.patch
	"${FILESDIR}"/${P}-gcc14.patch
)

src_configure() {
	eqmake5 "CASCADE_INC_DIR=/usr/include/opencascade" "CASCADE_LIB_DIR=/usr/$(get_libdir)/opencascade" "ASSIMP_INC_DIR=/usr/include/assimp" "ASSIMP_LIB_DIR=/usr/$(get_libdir)" mayo.pro
}

src_install() {
	emake install INSTALL_ROOT="${ED}"
	dobin mayo
	newicon -s scalable images/appicon.svg mayo.svg
	make_desktop_entry "mayo %F" Mayo mayo "Graphics;" "MimeType=model/step;model/iges;model/brep;image/vnd.dxf;model/obj;model/gltf+json;model/gltf+binary;model/vrml;model/stl;model/x.stl-ascii;model/x.stl-binary;application/x-amf;application/x-coff;application/x-coffexec;model/3mf;image/x-3ds;model/vnd.collada+xml;model/x3d+binary;model/x3d+fastinfoset;model/x3d+vrml;model/x3d+xml;model/x3d-vrml;application/directx;"
	einstalldocs
}
