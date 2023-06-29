# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="${PN}-portable-${PV}"
DESCRIPTION="Portable version of the Game of Trees version control system"
HOMEPAGE="https://gameoftrees.org"
SRC_URI="https://gameoftrees.org/releases/portable/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# `make check` does nothing
RESTRICT="test"

RDEPEND="
	dev-libs/libevent:=
	sys-libs/ncurses:=[unicode(+)]
	sys-libs/zlib:=
	elibc_Darwin? (
		dev-libs/ossp-uuid
	)
	elibc_SunOS? (
		sys-libs/libuuid
	)
	!elibc_Darwin? (
		dev-libs/libbsd
		!elibc_SunOS? (
			app-crypt/libmd
			sys-apps/util-linux
		)
	)
"
DEPEND="${RDEPEND}
	kernel_linux? ( sys-kernel/linux-headers )
"
BDEPEND="
	virtual/pkgconfig
	app-alternatives/yacc
"

DOCS=( CHANGELOG CHANGES README TODO )

QA_CONFIG_IMPL_DECL_SKIP=1
