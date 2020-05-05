# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils
DESCRIPTION="API Generator for Database acces."
HOMEPAGE="https://github.com/azaeldevel/apidb"
SRC_URI="https://github.com/azaeldevel/apidb/archive/4.3.0-beta.2.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="dev-libs/libxml2 dev-libs/boost sys-devel/bison sys-devel/flex x11-libs/gtk+ dev-libs/libtar dev-db/mariadb dev-libs/octetos-db-maria media-gfx/imagemagick"

src_unpack() {
	unpack ${A}
	ln -s apidb-4.3.0-beta.2 $P
	ls
}
src_prepare(){
	sed -i 's/lib/${LIBDIR}/' src/CMakeLists.txt || die
	#sed -i 's/lib/${LIBDIR}/' src/mysql-reader-c++/CMakeLists.txt  || die
	sed -i 's/lib/${LIBDIR}/' src/mariadb-reader-c++/CMakeLists.txt  || die
cmake-utils_src_prepare
}
src_configure() {
local mycmakeargs=(-DCMAKE_BUILD_TYPE=Debug -DAPIDB_VERSION_STAGE=betarelease -DAPIDB_MARIADB=Y -Wno-dev)
cmake-utils_src_configure
}
src_compile(){
cmake-utils_src_compile
}
src_install(){
cmake-utils_src_install
}
