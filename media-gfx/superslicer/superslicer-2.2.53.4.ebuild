# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

WX_GTK_VER="3.0-gtk3"

inherit xdg cmake desktop wxwidgets

MY_PN="SuperSlicer"
DESCRIPTION="A mesh slicer to generated G-Code for fused-filament fabrication"
HOMEPAGE="https://github.com/supermerill/SuperSlicer"
SRC_URI="https://github.com/supermerill/SuperSlicer/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="AGPL-3"
SLOT="22"
KEYWORDS="~amd64"
IUSE="gui test"

# tests fail to link with USE=-gui, bug #760096
REQUIRED_USE="test? ( gui )"
RESTRICT="!test? ( test )"

RDEPEND="
		~dev-cpp/tbb-2020.3
		>=dev-libs/boost-1.73.0:=[nls,threads(+)]
		dev-libs/c-blosc
		dev-libs/cereal
		dev-libs/openssl
		>=dev-libs/miniz-2.1.0-r2
		media-gfx/openvdb:0/7
		media-libs/qhull:=
		media-libs/openexr:=
		sci-libs/libigl
		sci-libs/nlopt
		>=sci-mathematics/cgal-5.0:=
		sys-libs/zlib:=
		gui? (
				dev-libs/glib:2
				media-libs/glew:0=
				net-misc/curl
				virtual/glu
				virtual/opengl
				x11-libs/gtk+:3
				x11-libs/wxGTK:${WX_GTK_VER}[X,opengl]
		)
"
DEPEND="${RDEPEND}
		media-libs/qhull[static-libs]
		test? ( dev-cpp/gtest )
"

PATCHES=(
	"${FILESDIR}/boost-endian-${PV}.patch"
	"${FILESDIR}/miniz-zip-header-${PV}.patch"
	"${FILESDIR}/freecad-dialog-${PV}.patch"
	"${FILESDIR}/boost-mouse-atomic-${PV}.patch"
	"${FILESDIR}/Support-for-HiDPI-in-OpenGL-on-Linux-GTK3-${PV}.patch"
	"${FILESDIR}/version-suffix-${PV}.patch"
)

src_configure() {
	use gui && setup-wxwidgets

	CMAKE_BUILD_TYPE=Release
	local mycmakeargs=(
		-DSLIC3R_BUILD_TESTS=$(usex test)
		-DSLIC3R_FHS=1
		-DSLIC3R_GUI=$(usex gui)
		-DSLIC3R_PCH=0
		-DSLIC3R_WX_STABLE=1
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	if use gui; then
		newicon -s 128 resources/icons/Slic3r_128px.png SuperSli3er_2.2.png
		make_desktop_entry superslicer "SuperSlicer 2.2" "SuperSli3er_2.2" "Graphics;3DGraphics;Engineering;" \
			"MimeType=model/stl;application/vnd.ms-3mfdocument;application/prs.wavefront-obj;application/x-amf;" \
			"GenericName=3D Printing Software" \
			"Keywords=3D;Printing;Slicer;slice;3D;printer;convert;gcode;stl;obj;amf;SLA"
	fi
}
