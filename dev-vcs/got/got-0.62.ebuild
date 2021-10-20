# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

MY_PN="${PN}-portable"
DESCRIPTION="Portable version of the Game of Trees version control system"
HOMEPAGE="https://gameoftrees.org"
SRC_URI="https://gameoftrees.org/releases/portable/${MY_PN}-${PV}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	sys-libs/ncurses:=[unicode(+)]
	sys-libs/zlib:=
	elibc_Darwin? ( sys-libs/native-uuid )
	elibc_SunOS? ( sys-libs/libuuid )
	!elibc_Darwin? ( dev-libs/libbsd )
	!elibc_Darwin? ( !elibc_SunOS? (
		app-crypt/libmd
		sys-apps/util-linux
	) )
"
BDEPEND="
	virtual/pkgconfig
	virtual/yacc
"
RDEPEND="${DEPEND}"

DOCS=( CHANGELOG CHANGES README TODO )

src_compile() {
	emake AR=$(tc-getAR) GOT_RELEASE=Yes
}
