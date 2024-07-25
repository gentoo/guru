# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR="emake"
CMAKE_BINARY=cmake
CMAKE_MAKEFILE_GENERATOR=emake

inherit cmake

MYPV="${PV/_beta/-beta}"
MYPN="${PN}"
MYP="${MYPN}-${MYPV}"

DESCRIPTION="API Generator for Database access"
HOMEPAGE="https://github.com/azaeldevel/apidb"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/azaeldevel/apidb.git"
else
	SRC_URI="https://github.com/azaeldevel/${PN}/archive/${MYPV}.tar.gz"
	KEYWORDS="~amd64"
fi

S="${WORKDIR}/${PN}-${MYPV}"

LICENSE="GPL-3"
SLOT="0"

IUSE="+mariadb postgresql commands gtk +corelibs"

RDEPEND="
	dev-libs/libxml2
	dev-libs/boost
	dev-libs/octetos-coreutils
	dev-libs/octetos-db-abstract
	gtk? ( x11-libs/gtk+:3 )
	dev-libs/libtar
	mariadb? ( dev-libs/octetos-db-maria )
	postgresql? ( dev-libs/octetos-db-postgresql )
	gnome-base/librsvg
"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
"

src_prepare() {
	sed -i 's/lib/${LIBDIR}/' src/CMakeLists.txt || die
	sed -i 's/lib/${LIBDIR}/' src/mysql-reader-c++/CMakeLists.txt  || die
	sed -i 's/lib/${LIBDIR}/' src/mariadb-reader-c++/CMakeLists.txt  || die
	sed -i 's/lib/${LIBDIR}/' src/postgresql-reader-c++/CMakeLists.txt  || die

	cmake_src_prepare
}

src_configure() {
	APIDBBUILD="CORE"
	APIDBINSTALL=""
	if use corelibs ;then
		APIDBINSTALL="CORE"
	fi
	if use mariadb ;then
		APIDBBUILD="$APIDBBUILD;MARIADB"
		APIDBINSTALL="$APIDBINSTALL;DRIVERS"
	fi
	if use postgresql ;then
		APIDBBUILD="$APIDBBUILD;POSTGRESQL"
		APIDBINSTALL="$APIDBINSTALL;DRIVERS"
	fi
	if use commands ;then
		APIDBINSTALL="$APIDBINSTALL;COMMANDS"
	fi
	if use gtk ;then
		APIDBINSTALL="$APIDBINSTALL;GTK3"
	fi
	local mycmakeargs=(-DAPIDB_VERSION_STAGE=alpha -DPLATFORM=LINUX_GENTOO -DAPIDBBUILD=$APIDBBUILD -DAPIDBINSTALL=$APIDBINSTALL)
	cmake_src_configure
}
