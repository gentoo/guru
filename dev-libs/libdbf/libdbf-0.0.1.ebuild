# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

inherit autotools

MY_COMMIT="d86e1dfb1e70f61b9227817dbccd20955cd8a86a"

DESCRIPTION="Library to read the content of dBASE III, IV, and 5.0 files"
HOMEPAGE="https://github.com/rollinhand/libdbf"
SRC_URI="https://github.com/rollinhand/libdbf/archive/${MY_COMMIT}.tar.gz -> ${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="${RDEPEND}
	dev-perl/XML-Parser
	doc? ( app-text/docbook-sgml-utils )
	virtual/pkgconfig"
BDEPEND="dev-util/intltool"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	if use doc; then
		export DOC_TO_MAN=docbook2man
	fi
	econf
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	find "${ED}" -name '*.la' -delete || die
}
