# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Wt, C++ Web Toolkit"
HOMEPAGE="https://www.webtoolkit.eu/wt https://github.com/emweb/wt"
SRC_URI="https://github.com/emweb/wt/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="doc +graphicsmagick mysql opengl +pango pdf postgres +sqlite ssl wttest"
REQUIRED_USE="
	pango? ( || ( graphicsmagick pdf ) )
	opengl? ( graphicsmagick )
"
# TODO: auto-test with wttest
RESTRICT="test"

DEPEND="
	dev-libs/boost:=
	sys-libs/zlib
	graphicsmagick? ( media-gfx/graphicsmagick:=[jpeg,png] )
	mysql? (
		virtual/mysql
		|| (
			dev-db/mariadb-connector-c
			dev-db/mysql-connector-c
		)
	)
	opengl? (
		media-libs/glew:=
		media-libs/libglvnd[X]
	)
	pango? (
		dev-libs/glib:2
		media-libs/fontconfig
		x11-libs/pango
	)
	pdf? ( media-libs/libharu:= )
	postgres? ( dev-db/postgresql )
	sqlite? ( dev-db/sqlite:3 )
	ssl? ( dev-libs/openssl:= )
"
RDEPEND="${DEPEND}"
BDEPEND="
	doc? (
		app-text/doxygen
		dev-qt/qttools:6[assistant]
		dev-ruby/asciidoctor
		media-gfx/graphviz[cairo]
	)
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}/wt-no-rundir.patch" )

src_prepare() {
	cmake_src_prepare

	# remove bundled sqlite
	rm -r src/Wt/Dbo/backend/amalgamation || die

	if use doc; then
		doxygen -u Doxyfile 2>/dev/null || die
		doxygen -u examples/Doxyfile 2>/dev/null || die
		sed -e "/^QHG_LOCATION/s|qhelpgenerator|/usr/$(get_libdir)/qt6/libexec/&|" \
			-i Doxyfile || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR=$(get_libdir)
		-DBUILD_EXAMPLES=OFF
		-DBUILD_TESTS=OFF
		-DDOCUMENTATION_DESTINATION="share/doc/${PF}"
		-DINSTALL_DOCUMENTATION=$(usex doc)
		# will be deprecated
		-DCONNECTOR_FCGI=OFF
		-DCONNECTOR_HTTP=ON
		-DENABLE_SSL=$(usex ssl)
		-DENABLE_HARU=$(usex pdf)
		-DENABLE_PANGO=$(usex pango)
		-DENABLE_SQLITE=$(usex sqlite)
		-DENABLE_POSTGRES=$(usex postgres)
		-DENABLE_MYSQL=$(usex mysql)
		-DENABLE_FIREBIRD=OFF
		-DENABLE_LIBWTTEST=$(usex wttest)
		# QT is only required for examples
		-DENABLE_QT4=OFF
		-DENABLE_QT5=OFF
		-DENABLE_QT6=OFF
		# requires shibboleth and opensaml, not in tree
		-DENABLE_SAML=OFF
		-DENABLE_OPENGL=$(usex opengl)
		-DWT_WRASTERIMAGE_IMPLEMENTATION=$(usex graphicsmagick GraphicsMagick none)
	)

	if use mysql || use postgres || use sqlite; then
		mycmakeargs+=( -DENABLE_LIBWTDBO=ON )
		if use sqlite; then
			mycmakeargs+=( -DUSE_SYSTEM_SQLITE3=ON )
			# DboTest.C: In member function ‘void Sqlite3_Test_Suite::dbo_precision_test2::test_method()’
			if use wttest; then
			append-flags -fno-strict-aliasing
			filter-lto
			fi
		fi
	else
		mycmakeargs+=( -DENABLE_LIBWTDBO=OFF )
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install

	if use doc; then
		find "${ED}" \( \
			-iname '*.map' -o \
			-iname '*.md5' \
			\) -delete || die

		docompress -x /usr/share/doc/${PF}/{examples,reference,tutorial}
	fi
}
