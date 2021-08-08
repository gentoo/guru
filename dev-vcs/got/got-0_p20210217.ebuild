# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools toolchain-funcs

MY_PN="${PN}-portable"
COMMIT="36536ee0b0fb5108076d8238a4b78c59db9dac3d"  # "linux" branch
DESCRIPTION="Portable version of the Game of Trees version control system"
HOMEPAGE="https://gameoftrees.org"
SRC_URI="https://git.gameoftrees.org/gitweb/?p=${MY_PN}.git;a=snapshot;h=${COMMIT};sf=tgz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT:0:7}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-libs/openssl:=
	sys-libs/ncurses:=
	sys-libs/zlib:=
	elibc_Darwin? ( sys-libs/native-uuid )
	elibc_SunOS? ( sys-libs/libuuid )
	!elibc_Darwin? (
		dev-libs/libbsd
		!elibc_SunOS? (
			app-crypt/libmd
			sys-apps/util-linux
		)
	)
"
RDEPEND="${DEPEND}
	dev-vcs/git
"
BDEPEND="
	virtual/pkgconfig
	virtual/yacc
"

DOCS=( CHANGES README README.portable )

src_prepare() {
	default

	# remove debugging flags (-Werror, -g, ...)
	sed "s/\(GOT_RELEASE\)=No/\1=Yes/" -i configure.ac || die
	sed "/AM_CFLAGS += -g/d" -i Makefile.am || die

	eautoreconf
}

src_compile() {
	emake AR=$(tc-getAR)
}

src_install() {
	default
	doman got/*.5
}
