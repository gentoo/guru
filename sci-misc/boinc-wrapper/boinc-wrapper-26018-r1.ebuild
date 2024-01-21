# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools edo

DESCRIPTION="Wrapper to use non-BOINC apps with BOINC"
HOMEPAGE="https://boinc.berkeley.edu/trac/wiki/WrapperApp"
SRC_URI="https://github.com/BOINC/boinc/archive/refs/tags/wrapper/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~arm64 ~x86"
LICENSE="Info-ZIP LGPL-3+ regexp-UofT"
SLOT="0"

# libboinc-api dependencies
# no subslot, because "-Wl,--as-needed" removes them
DEPEND="
	dev-libs/openssl
	media-libs/freeglut
	media-libs/libjpeg-turbo
"

DOCS=( job.xml )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	edo bash generate_svn_version.sh
	econf --enable-static --enable-pkg-devel --disable-fcgi
}

src_compile() {
	emake
	emake -C samples/wrapper
}

src_install() {
	cd samples/wrapper || die

	einstalldocs
	newbin wrapper boinc-wrapper
}
