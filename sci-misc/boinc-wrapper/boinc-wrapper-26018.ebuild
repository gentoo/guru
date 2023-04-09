# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

BOINC_SUBMODULE="samples/wrapper"
inherit boinc

DESCRIPTION="Wrapper to use non-BOINC apps with BOINC"
HOMEPAGE="https://boinc.berkeley.edu/trac/wiki/WrapperApp"

KEYWORDS="~amd64 ~arm64 ~x86"
LICENSE="Info-ZIP LGPL-3+ regexp-UofT"
SLOT="0"

# libboinc-api dependencies
DEPEND="
	dev-libs/openssl
	media-libs/freeglut
	media-libs/libjpeg-turbo
"

DOCS=( job.xml )

boinc_require_source ${PV} wrapper
boinc_enable_autotools

src_compile() {
	pushd "${BOINC_BUILD_DIR}" || die
	emake
	popd || die

	emake
}

src_install() {
	einstalldocs
	newbin wrapper boinc-wrapper
}
