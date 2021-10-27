# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR="emake"
FORTRAN_STANDARD=2003

inherit cmake fortran-2

DESCRIPTION="A GTK+ binding to build Graphical User Interfaces in Fortran"
HOMEPAGE="https://github.com/vmagnin/gtk-fortran"
SRC_URI="https://github.com/vmagnin/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"

IUSE="examples high-level plplot static-libs"
REQUIRED_USE="plplot? ( high-level )"

RDEPEND="
	gui-libs/gtk:4
	plplot? ( >=sci-libs/plplot-5.13.0[cairo,fortran] )
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/fortran
	virtual/pkgconfig
"

DOCS=( "README.md" "README-high-level.md" "CHANGELOG.md" )

pkg_setup() {
	fortran-2_pkg_setup
}

src_prepare() {
	default
	# Fix library installation path and disable 'sketcher' build
	sed -i -e "s:CMAKE_INSTALL_LIBDIR lib:CMAKE_INSTALL_LIBDIR $(get_libdir):" \
	-e "s:    add_subdirectory(sketcher)::" CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	mycmakeargs+=(
		-DEXCLUDE_PLPLOT=$(usex plplot false true)
		-DNO_BUILD_HL=$(usex high-level false true)
		-DINSTALL_EXAMPLES=$(usex examples)
		-DNO_BUILD_EXAMPLES=true
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	# Remove static library here as it's used to build additional tools
	if use !static-libs ; then
		rm "${ED}/usr/$(get_libdir)/libgtk-${SLOT}-fortran.a" || die
	fi
}
