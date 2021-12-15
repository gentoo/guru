# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

WX_GTK_VER="3.0-gtk3"

inherit xdg cmake desktop wxwidgets

MY_PN="SuperSlicer"
DESCRIPTION="A mesh slicer to generated G-Code for fused-filament fabrication"
HOMEPAGE="https://github.com/supermerill/SuperSlicer"
SRC_URI="https://github.com/supermerill/SuperSlicer/archive/${PV}.tar.gz -> ${P}.tar.gz
	profiles? ( https://github.com/slic3r/slic3r-profiles/archive/118aa919c16837eb2ff6ba97e2934fa4144ef806.tar.gz -> ${P}-profiles.tar.gz )"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="AGPL-3"
SLOT="23"
KEYWORDS="~amd64"
IUSE="gui test profiles"

# tests fail to link with USE=-gui, bug #760096
REQUIRED_USE="test? ( gui )"
RESTRICT="!test? ( test )"

RDEPEND="
		dev-cpp/eigen:3
		dev-cpp/tbb
		>=dev-libs/boost-1.73.0:=[nls,threads(+)]
		dev-libs/cereal
		dev-libs/expat
		dev-libs/c-blosc
		dev-libs/gmp:=
		>=dev-libs/miniz-2.1.0-r2
		dev-libs/mpfr:=
		>=media-gfx/openvdb-5.0.0
		media-libs/ilmbase:=
		media-libs/libpng:0=
		media-libs/openexr:0=
		media-libs/qhull:=
		sci-libs/libigl
		sci-libs/nlopt
		>=sci-mathematics/cgal-5.0:=
		sys-apps/dbus
		sys-libs/zlib:=
		gui? (
				dev-libs/glib:2
				media-libs/glew:0=
				net-misc/curl
				virtual/glu
				virtual/opengl
				x11-libs/gtk+:3
				>=x11-libs/wxGTK-3.0.5.1:=[X,opengl]
		)
"
DEPEND="${RDEPEND}
		media-libs/qhull[static-libs]
		test? ( dev-cpp/gtest )
"

PATCHES=(
	"${FILESDIR}/miniz-zip-header-2.2.53.4.patch"
	"${FILESDIR}/freecad-dialog-2.2.53.4.patch"
	"${FILESDIR}/missing-imports-${PV}.patch"
	"${FILESDIR}/string-to-char-conversion-${PV}.patch"
	"${FILESDIR}/version-suffix-${PV}.patch"
	"${FILESDIR}/wxwidget-canvas-set-context-2.3.56.9.patch"
)

src_unpack() {
	unpack ${P}.tar.gz
	mv "${S}/resources/icons/SuperSlicer_192px.png" "${S}/resources/icons/SuperSlicer2.3_192px.png" || die "Failed to rename icons"
	mv "${S}/resources/icons/SuperSlicer_128px.png" "${S}/resources/icons/SuperSlicer2.3_128px.png" || die "Failed to rename icons"
	mv "${S}/resources/icons/SuperSlicer-gcodeviewer_128px.png" "${S}/resources/icons/SuperSlicer2.3-gcodeviewer_128px.png" || die "Failed to rename icons"
	mv "${S}/resources/icons/SuperSlicer-gcodeviewer_192px.png" "${S}/resources/icons/SuperSlicer2.3-gcodeviewer_192px.png" || die "Failed to rename icons"
	cp "${S}/resources/icons/SuperSlicer.png" "${S}/resources/icons/SuperSlicer2.3_logo.png" || die "Failed to make logo icon"

	use profiles && unpack ${P}-profiles.tar.gz &&
	if use profiles ; then
		cp -r "${WORKDIR}/slic3r-profiles-118aa919c16837eb2ff6ba97e2934fa4144ef806/"* "${S}/resources/profiles" || die "Failed to copy profiles"
	fi
}

src_configure() {
	use gui && setup-wxwidgets

	CMAKE_BUILD_TYPE=Release
	local mycmakeargs=(
		-DSLIC3R_BUILD_TESTS=$(usex test)
		-DSLIC3R_FHS=ON
		-DSLIC3R_GTK=3
		-DSLIC3R_GUI=$(usex gui)
		-DSLIC3R_PCH=OFF
		-DSLIC3R_WX_STABLE=ON
		-Wno-dev
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	if use gui; then
		newicon -s 128 resources/icons/Slic3r_128px.png SuperSli3er_2.3.png
		dosym superslicer-2.3 /usr/bin/superslicer-2.3-gcodeviewer
		make_desktop_entry superslicer "SuperSlicer 2.3" "SuperSli3er_2.3" "Graphics;3DGraphics;Engineering;" \
			"MimeType=model/stl;application/vnd.ms-3mfdocument;application/prs.wavefront-obj;application/x-amf;" \
			"GenericName=3D Printing Software" \
			"Keywords=3D;Printing;Slicer;slice;3D;printer;convert;gcode;stl;obj;amf;SLA"
	fi
}
