# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

MYPV="${PV/_alpha/-alpha}"
MYPN="${PN}"
MYP="${MYPN}-${MYPV}"

DESCRIPTION="API Generator for Database acces."
HOMEPAGE="https://github.com/azaeldevel/apidb"
SRC_URI="https://github.com/azaeldevel/${PN}/archive/${MYPV}.2.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+mariadb postgresql"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/libxml2
	dev-libs/boost
	sys-devel/bison
	sys-devel/flex
	x11-libs/gtk+
	dev-libs/libtar
	mariadb? ( dev-libs/octetos-db-maria )
	postgresql? ( dev-libs/octetos-db-postgresql )
	media-gfx/imagemagick
"

S="${WORKDIR}/${PN}-${MYPV}.2"

src_prepare() {
	sed -i 's/lib/${LIBDIR}/' src/CMakeLists.txt || die
	#sed -i 's/lib/${LIBDIR}/' src/mysql-reader-c++/CMakeLists.txt  || die
	sed -i 's/lib/${LIBDIR}/' src/mariadb-reader-c++/CMakeLists.txt  || die
	sed -i 's/lib/${LIBDIR}/' src/postgresql-reader-c++/CMakeLists.txt  || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(-DAPIDB_VERSION_STAGE=alpha -DPLATFORM=Gentoo -DCOMPONENT=FULL)
	if use mariadb ;then
		mycmakeargs+=(-DAPIDB_MARIADB=Y)
	fi
	if use postgresql ;then
		mycmakeargs+=(-DAPIDB_POSTGRESQL=Y)
	fi
	cmake_src_configure
}
