# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A C++ class library for writing CGI applications"
HOMEPAGE="https://www.gnu.org/software/cgicc/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="LGPL-3 doc? ( FDL-1.2 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples static-libs"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )"

PATCHES=( "${FILESDIR}/${PN}-3.2.19-optional-doc.patch" )

# False positive, bug #785328.
QA_SONAME="usr/lib*/libcgicc.so*"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable examples demos) \
		$(use_enable doc) \
		$(use_enable static-libs static)
}

src_install() {
	default

	find "${D}" -name '*.la' -delete || die

	if use examples; then
		docinto examples
		dodoc {contrib,demo}/{*.{cpp,h},*.cgi,README}
	fi
}
