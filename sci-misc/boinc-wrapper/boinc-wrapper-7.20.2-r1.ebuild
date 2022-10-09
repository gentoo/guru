# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

BOINC_SUBMODULE="samples/wrapper"
inherit boinc

DESCRIPTION="Wrapper to use non-BOINC apps with BOINC"
HOMEPAGE="https://boinc.berkeley.edu/trac/wiki/WrapperApp"

KEYWORDS="~amd64 ~arm64 ~x86"
LICENSE="LGPL-3+ regexp-UofT"
SLOT="0"

RDEPEND="
	>=sci-misc/boinc-7.20
	>=dev-libs/boinc-zip-7.20
"
DEPEND="${RDEPEND}"

DOCS=( job.xml )

boinc_require_source

boinc_override_config "${FILESDIR}"/config.override.h

src_prepare() {
	boinc_src_prepare
	cp "${FILESDIR}"/Makefile.gentoo "${S}" || die
}

src_compile() {
	emake -f Makefile.gentoo
}

src_install() {
	einstalldocs
	dobin boinc-wrapper
}
