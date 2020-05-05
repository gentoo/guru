# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

MYPV="${PV/_beta/-beta.2}"

DESCRIPTION="API Generator for Database acces."
HOMEPAGE="https://github.com/azaeldevel/apidb"
SRC_URI="https://github.com/azaeldevel/${PN}/archive/${MYPV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/libxml2
	dev-libs/boost
	sys-devel/bison
	sys-devel/flex
	x11-libs/gtk+
	dev-libs/libtar
	dev-db/mariadb
	dev-libs/octetos-db-maria
	media-gfx/imagemagick
"

S="${WORKDIR}/${PN}-${MYPV}"

src_prepare() {
	sed -i 's/lib/${LIBDIR}/' src/CMakeLists.txt || die
	#sed -i 's/lib/${LIBDIR}/' src/mysql-reader-c++/CMakeLists.txt  || die
	sed -i 's/lib/${LIBDIR}/' src/mariadb-reader-c++/CMakeLists.txt  || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(-DCMAKE_BUILD_TYPE=Debug -DAPIDB_VERSION_STAGE=betarelease -DAPIDB_MARIADB=Y -Wno-dev)
	cmake_src_configure
}
