# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

BOINC_SUBMODULE="zip"
inherit boinc

DESCRIPTION="Wrapper for the zip/unzip functions to expose to BOINC clients"
HOMEPAGE="https://boinc.berkeley.edu/trac/wiki/FileCompression"

KEYWORDS="~amd64 ~arm ~arm64 ~x86"
LICENSE="Info-ZIP LGPL-3+"
SLOT="0"

# broken beyond repair
RESTRICT="test"

boinc_require_source ${PV}.0
boinc_enable_autotools

src_compile() {
	emake lib${PN//-/_}.la
}

src_install() {
	emake install-{libLTLIBRARIES,pkgincludeHEADERS} DESTDIR="${D}"
	find "${ED}" -name '*.la' -delete || die
}
