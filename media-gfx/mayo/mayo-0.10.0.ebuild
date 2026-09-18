# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop xdg
CMAKE_IN_SOURCE_BUILD="YES"

DESCRIPTION="Opensource 3D CAD viewer and converter"
HOMEPAGE="https://github.com/fougue/mayo"
SRC_URI="https://github.com/fougue/mayo/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qttranslations:6
	dev-qt/qtbase:6[opengl]
	>=media-libs/assimp-5.3.1
	>=sci-libs/opencascade-7.8.0
"

DEPEND="${RDEPEND}"


src_install() {
	dobin mayo
	dobin mayo-conv
	newicon -s scalable images/appicon.svg mayo.svg
	make_desktop_entry "mayo %F" Mayo mayo "Graphics;" "MimeType=model/step;model/iges;model/brep;image/vnd.dxf;model/obj;model/gltf+json;model/gltf+binary;model/vrml;model/stl;model/x.stl-ascii;model/x.stl-binary;application/x-amf;application/x-coff;application/x-coffexec;model/3mf;image/x-3ds;model/vnd.collada+xml;model/x3d+binary;model/x3d+fastinfoset;model/x3d+vrml;model/x3d+xml;model/x3d-vrml;application/directx;"
	einstalldocs
}
