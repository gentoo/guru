# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

BOINC_MASTER_URL="https://gene.disi.unitn.it/test/"
BOINC_INVITATION_CODE="science@tn"
BOINC_HELPTEXT=\
"gene@home is a part of TN-Grid BOINC project."

inherit boinc-app edo toolchain-funcs

MY_PN="pc-boinc"
COMMIT="3186afba409a"

DESCRIPTION="BOINC application for expanding Gene Regulatory Networks (GRN)"
HOMEPAGE+=" https://bitbucket.org/francesco-asnicar/pc-boinc"
SRC_URI="https://bitbucket.org/francesco-asnicar/${MY_PN}/get/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/francesco-asnicar-${MY_PN}-${COMMIT}"

LICENSE="sunpro public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="app-arch/bzip2"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-1.10-include.patch
	"${FILESDIR}"/${PN}-1.10-iostream.patch
	"${FILESDIR}"/${PN}-1.10-makefile.patch
)

DOCS=( Readme.md )

boinc-app_add_deps

src_compile() {
	tc-export CC CXX

	emake -C src BOINC_DIR="${ESYSROOT}"/usr/include/boinc
}

src_test() {
	edo bash ./test_run.sh
	edo bash ./test_run2.sh
}

src_install() {
	doappinfo "${FILESDIR}"/app_info.xml

	exeinto $(get_project_root)
	exeopts -m 0755 --owner root --group boinc
	newexe bin/pc "gene_pcim_v${PV}"
}
