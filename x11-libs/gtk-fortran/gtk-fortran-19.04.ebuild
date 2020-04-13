# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR="emake"
FORTRAN_STANDARD=2003

inherit cmake fortran-2

DESCRIPTION="A GTK+ binding to build Graphical User Interfaces in Fortran"
HOMEPAGE="https://github.com/vmagnin/gtk-fortran"
SRC_URI="https://github.com/vmagnin/${PN}/archive/v${PV}.gtk3.24.8.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${P}.gtk3.24.8"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc examples plplot"

RDEPEND="
	x11-libs/gtk+:3
	plplot? ( >=sci-libs/plplot-5.13.0[cairo,fortran] )
"

DEPEND="
	${RDEPEND}
	doc? ( app-doc/doxygen[dot] )
"

BDEPEND="
	virtual/fortran
	virtual/pkgconfig
"

DOCS=( "README.md" "README-high-level" "CHANGELOG.md" )

pkg_setup() {
	fortran-2_pkg_setup
}

src_prepare() {
	default
	# Fix library installation path
	sed -i "s:CMAKE_INSTALL_LIBDIR lib:CMAKE_INSTALL_LIBDIR $(get_libdir):" CMakeLists.txt || die
	# Fix "Some or all of the gtk libraries were not found. (missing: GTK3_GDKCONFIG_INCLUDE_DIR)",
	# ref: https://github.com/vmagnin/gtk-fortran/commit/d3c1682
	sed -i "s:GTK3_GDKCONFIG gdkconfig.h:GTK3_GDKCONFIG gdk/gdkconfig.h:" cmake/FindGTK3.cmake || die

	cmake_src_prepare
}

src_configure() {
	mycmakeargs+=(
		-DEXCLUDE_PLPLOT=$(usex plplot false true)
		-DINSTALL_EXAMPLES=$(usex examples)
		-DNO_BUILD_EXAMPLES=true
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use doc && cmake_src_compile doxygen
}

src_install() {
	cmake_src_install
	use doc && dodoc -r "${BUILD_DIR}"/html && rm "${D}/usr/share/doc/${P}"/html/{*.map,*.md5}
}
