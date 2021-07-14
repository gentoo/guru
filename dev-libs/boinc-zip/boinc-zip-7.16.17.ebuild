# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

MY_PV=$(ver_cut 1-2)

DESCRIPTION="Wrapper for the zip/unzip functions to expose to BOINC clients"
HOMEPAGE="https://boinc.berkeley.edu/trac/wiki/FileCompression"

SRC_URI="https://github.com/BOINC/boinc/archive/client_release/${MY_PV}/${PV}.tar.gz -> boinc-${PV}.tar.gz"
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}/boinc-client_release-${MY_PV}-${PV}/zip"

LICENSE="Info-ZIP LGPL-3+"
SLOT="0"

src_prepare() {
	default
	sed '/$(LN) .libs\/$(LIBBOINC_ZIP_STATIC)/d' -i Makefile.am || die

	cd .. || die
	eautoreconf
}

src_configure() {
	cd .. || die
	econf --enable-pkg-devel --disable-static
}

src_install() {
	default
	rm "${ED}"/usr/*/libboinc_zip.la || die
}
