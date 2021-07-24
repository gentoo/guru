# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

BOINC_SUBMODULE="samples/wrapper"
inherit boinc

DESCRIPTION="Wrapper to use non-BOINC apps with BOINC"
HOMEPAGE="https://boinc.berkeley.edu/trac/wiki/WrapperApp"

KEYWORDS="~amd64 ~arm64 ~x86"
LICENSE="LGPL-3+ regexp-UofT"
SLOT="0"

# sci-misc/boinc doesn't have all necessary headers, so
# we have to include from build root. All that said,
# versions must not mismatch.
RDEPEND="
	~sci-misc/boinc-${PV}
	>=dev-libs/boinc-zip-${PV}
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-$(ver_cut 1-2)-makefile.patch )
DOCS=( job.xml )

boinc_require_source

boinc_override_config "${FILESDIR}"/config.override.h

src_install() {
	einstalldocs
	newbin wrapper boinc-wrapper
}
