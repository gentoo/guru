# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Encryption/authentication library, RSA/MDX/DES"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI="https://archive.netbsd.org/pub/pkgsrc-archive/distfiles/2021Q3/${PN}.tar.Z -> ${P}.tar.Z"
S="${WORKDIR}"

LICENSE="RSAREF"
SLOT="0/3"
KEYWORDS="~amd64"

BDEPEND="sys-devel/libtool"

PATCHES=(
	"${FILESDIR}"/${P}-global.patch
	"${FILESDIR}"/${P}-includes.patch
	"${FILESDIR}"/${P}-libtool.patch
	"${FILESDIR}"/${P}-rsa.patch
)

DOCS=( doc )

src_unpack() {
	default

	cd "${S}"/source || die
	mkdir ${PN} || die
	cp *.h ${PN} || die
}

src_compile() {
	# XXX: fails with slibtool
	emake -C install -f unix/makefile librsaref.la \
		LIBTOOL=libtool LIBDIR="${EPREFIX}/usr/$(get_libdir)"
}

src_install() {
	dolib.so install/.libs/lib${PN}.so*
	doheader -r source/${PN}
	einstalldocs
}
