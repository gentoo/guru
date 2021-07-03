# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic perl-module toolchain-funcs

DESCRIPTION="Connect to and exchange data with Siemens PLCs"
HOMEPAGE="https://sourceforge.net/projects/libnodave"
SRC_URI="mirror://sourceforge/libnodave/libnodave-${PV}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="perl"

RESTRICT="test" #no tests

RDEPEND="
	perl? ( dev-lang/perl:= )
"

DOCS=( ChangeLog readme faq.txt )
PATCHES=(
	"${FILESDIR}/makefile-${PV}.patch"
	"${FILESDIR}/perl-makefile.patch"
)

src_configure() {
	if use perl; then
		cd "${S}/PERL" || die
		perl-module_src_configure
	fi
	return
}

src_compile() {
	append-cflags "-L${S} -fPIC"
	emake clean
	emake CC="$(tc-getCC)" libnodave.so
	ln -s libnodave.so.0 libnodave.so || die
	emake CC="$(tc-getCC)" all

	if use perl; then
		cd "${S}/PERL" || die
		perl-module_src_compile
	fi
}

src_install() {
	local programs=(
		testIBH
		testISO_TCP
		testMPI
		testPPI
		testPPIload
		testMPIload
		testISO_TCPload
		testMPI_IBHload
		testPPI_IBHload
		testPPI_IBH
		testNLpro
		testAS511
		isotest4
		ibhsim5
	)
	exeinto "/usr/libexec/${PN}"
	doexe "${programs[@]}"
	dolib.so libnodave.so.0 libnodave.so
	doheader nodave.h
	HTML_DOCS=( doc/*.html )
	einstalldocs
	insinto "/usr/share/${PF}/doc/de"
	doins FAQ.de.txt

	if use perl; then
		cd "${S}/PERL" || die
		perl-module_src_install
	fi
}
