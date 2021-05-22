# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools toolchain-funcs

MY_PN="pc-boinc"
COMMIT="3186afba409a"

BOINC_VER=7.16.16
BOINC_RELEASE=$(ver_cut 1-2 "${BOINC_VER}")

DESCRIPTION="BOINC application for expanding Gene Regulatory Networks (GRN)"
HOMEPAGE="http://gene.disi.unitn.it/test/genehome https://bitbucket.org/francesco-asnicar/pc-boinc"
SRC_URI="https://github.com/BOINC/boinc/archive/client_release/${BOINC_RELEASE}/${BOINC_VER}.tar.gz -> boinc-${BOINC_VER}.tar.gz
	https://bitbucket.org/francesco-asnicar/${MY_PN}/get/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/boinc-client_release-${BOINC_RELEASE}-${BOINC_VER}/samples/${PN}"

LICENSE="sunpro public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	app-arch/bzip2
	sci-misc/boinc
"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=( "${FILESDIR}"/makefile.patch )

DOCS=( Readme.md )

src_unpack() {
	default
	mv "${WORKDIR}"/francesco-asnicar-* "${S}" || die
}

src_prepare() {
	default
	sed 's/stdio.h/iostream/' -i src/main.cpp || die
	sed 's/fprintf(stderr, \(.*\))/std::cerr << \1/g' -i src/main.cpp || die

	cd ../.. || die
	eautoreconf
}

src_configure() {
	cd ../.. || die
	econf --enable-pkg-devel --disable-static
}

src_compile() {
	tc-export CC CXX
	cd src || die
	emake
}

src_test() {
	bash test_run.sh || die
	bash test_run2.sh || die
}

src_install() {
	insinto /var/lib/boinc/projects/gene.disi.unitn.it_test
	doins "${FILESDIR}"/app_info.xml
	exeinto /var/lib/boinc/projects/gene.disi.unitn.it_test
	newexe bin/pc "gene_pcim_v${PV}"
}

pkg_postinst() {
	elog
	elog "gene@home is a part of TN-Grid BOINC project."
	elog
	elog "- Master URL: https://gene.disi.unitn.it/test/"
	elog "- Invitation code: science@tn"
}
