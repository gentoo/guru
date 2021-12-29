# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Public-key encryption and digital signature utility"
HOMEPAGE="https://web.archive.org/web/20170319101112/http://www.pgpi.org/"
SRC_URI="https://archive.netbsd.org/pub/pkgsrc-archive/distfiles/2021Q3/pgp263is.tar.gz"
S="${WORKDIR}"

LICENSE="PGP-2"
SLOT="0/2"
KEYWORDS="~amd64"
IUSE="bindist debug"

RDEPEND="bindist? ( dev-libs/rsaref )"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-sparc.patch
	"${FILESDIR}"/${P}-alpha.patch
	"${FILESDIR}"/${P}-includes.patch
	"${FILESDIR}"/${P}-getline.patch
)

DOCS=(
	readme.1st readme.usa setup.doc
	{de,en,es,fr,pgp}.hlp
	doc/{appnote,changes,keyserv,pgformat,politic}.doc
	doc/{blurb,faq,mitlicen}.txt
)

src_unpack() {
	default
	unpack "${WORKDIR}"/pgp263ii.tar
}

src_configure() {
	append-cflags -ansi
	append-cppflags -DUNIX -DIDEA32 -DMAX_NAMELEN=255 -DPORTABLE -DMPORTABLE
	use bindist && append-cppflags -DUSA
	use debug && append-cppflags -DDEBUG
	use x86 && append-cppflags -DASM
}

src_compile() {
	emake -C src all \
		CC=$(tc-getCC) LD=$(tc-getCC) CFLAGS="${CFLAGS}" \
		OBJS_EXT=$(usex x86 "_80386.o _zmatch.o" "") \
		RSALIBS=$(usex bindist "-lrsaref" "") \
		RSAOBJS=rsaglue$(usex bindist "2" "1").o
}

src_install() {
	dobin src/pgp
	doman doc/pgp.1
	einstalldocs
}
