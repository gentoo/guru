# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Wt, C++ Web Toolkit"
HOMEPAGE="https://www.webtoolkit.eu/wt https://github.com/emweb/wt"
SRC_URI="https://github.com/emweb/wt/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="doc mysql opengl +pango pdf postgres ssl"

DEPEND="
	dev-qt/qtbase:6
	<=dev-libs/boost-1.86.0:=
	media-libs/libharu
	media-gfx/graphicsmagick[jpeg,png]
	sys-libs/zlib

	mysql? ( virtual/mysql )
	opengl? ( virtual/opengl )
	pango? ( x11-libs/pango )
	postgres? ( dev-db/postgresql )
	ssl? ( dev-libs/openssl )
"
RDEPEND="${DEPEND}"

BDEPEND="
	doc? (
		app-text/doxygen[dot]
		dev-qt/qttools:6[qdoc]
	)
"

PATCHES=( "${FILESDIR}/wt-no-rundir.patch")

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR=$(get_libdir)
		-DBUILD_EXAMPLES=OFF
		-DINSTALL_DOCUMENTATION=$(usex doc)
		-DDOCUMENTATION_DESTINATION="share/doc/${PF}"
		-DENABLE_SSL=$(usex ssl)
		-DENABLE_HARU=$(usex pdf)
		-DENABLE_PANGO=$(usex pango)
		-DENABLE_SQLITE=ON
		-DENABLE_POSTGRES=$(usex postgres)
		-DENABLE_MYSQL=$(usex mysql)
		-DENABLE_FIREBIRD=OFF
		-DENABLE_QT4=OFF
		-DENABLE_QT5=OFF
		-DENABLE_QT6=ON
		-DENABLE_SAML=ON
		-DENABLE_OPENGL=$(usex opengl)
	)

	cmake_src_configure
}
