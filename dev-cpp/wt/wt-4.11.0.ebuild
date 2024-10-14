# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Wt, C++ Web Toolkit"
HOMEPAGE="https://www.webtoolkit.eu/wt https://github.com/emweb/wt"
SRC_URI="https://github.com/emweb/wt/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc firebird mysql opengl +pango pdf postgres ssl"

DEPEND="
	firebird? ( dev-db/firebird )
	mysql? ( virtual/mysql )
	opengl? ( virtual/opengl )
	pango? ( x11-libs/pango )
	postgres? ( dev-db/postgresql )
	ssl? ( dev-libs/openssl )
	dev-libs/boost:=
	media-libs/libharu
	media-gfx/graphicsmagick[jpeg,png]
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

BDEPEND="
	doc? (
		app-text/doxygen[dot]
		dev-qt/qtchooser
		dev-qt/qthelp
	)
"
# for qt6 dev-qt/qttools[qdoc]

PATCHES=( "${FILESDIR}/wt-no-rundir.patch")

src_configure() {
	# TODO
	#-DENABLE_QT6=$(usex qt6)

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
		-DENABLE_FIREBIRD=$(usex firebird)
		-DENABLE_MYSQL=$(usex mysql)
		-DENABLE_QT4=OFF
		-DENABLE_QT5=ON
		-DENABLE_SAML=ON
		-DENABLE_OPENGL=$(usex opengl)
	)

	cmake_src_configure
}
