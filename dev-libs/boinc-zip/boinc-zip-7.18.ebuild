# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

MY_PN=${PN%%-*}
MY_PV="${PV}.0"
DESCRIPTION="Wrapper for the zip/unzip functions to expose to BOINC clients"
HOMEPAGE="https://boinc.berkeley.edu/trac/wiki/FileCompression"

SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/client_release/${PV}/${MY_PV}.tar.gz -> ${MY_PN}-${MY_PV}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~x86"
S="${WORKDIR}/${MY_PN}-client_release-${PV}-${MY_PV}"

LICENSE="Info-ZIP LGPL-3+"
SLOT="0"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --enable-pkg-devel
}

src_compile() {
	emake -C zip lib${PN//-/_}.la
}

src_install() {
	emake -C zip install-{libLTLIBRARIES,pkgincludeHEADERS} DESTDIR="${D}"
	find "${ED}" -name '*.la' -delete || die
}
