# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

inherit autotools

MY_COMMIT="8c1df2e694ca81a2c2ff1d7de150629e69092ea1"

DESCRIPTION="Command line tool to read the content of dBASE III, IV, and 5.0 files"
HOMEPAGE="https://github.com/rollinhand/dbf-core"
SRC_URI="https://github.com/rollinhand/dbf-core/archive/${MY_COMMIT}.tar.gz -> ${P}.tgz"

S="${WORKDIR}/${PN}-core-${MY_COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-libs/libdbf"

DEPEND="${RDEPEND}
	dev-perl/XML-Parser
	doc? ( app-text/docbook-sgml-utils )
	virtual/pkgconfig"

src_prepare() {
	default
	if use doc; then
		sed -i -e 's|docbook-to-man|docbook2man|g' man/Makefile.am || die
	fi
	eautoreconf
}

src_configure() {
	if use doc; then
		export DOC_TO_MAN=docbook2man
	fi
	econf
	emake
	if use doc; then
		mv man/DBF.SECTION man/dbf.1 || die "Error moving man page"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}
