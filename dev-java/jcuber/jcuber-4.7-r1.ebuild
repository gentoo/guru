# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools java-pkg-2 java-pkg-simple

DESCRIPTION="Java reader library"
HOMEPAGE="https://www.scalasca.org/scalasca/software/cube-4.x/download.html"
SRC_URI="http://apps.fz-juelich.de/scalasca/releases/cube/${PV}/dist/${P}.tar.gz"
S="${WORKDIR}/${P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

CDEPEND="dev-java/xerces:2"
DEPEND="
	${CDEPEND}
	>=virtual/jdk-1.8:*
"
RDEPEND="
	${CDEPEND}
	>=virtual/jre-1.8:*
"

src_prepare() {
	java-pkg_clean
	default
	pushd build-frontend || die
	java-pkg_jar-from xerces-2
	popd || die
	eautoreconf
}

src_configure() {
	econf
}

src_compile() {
	MAKEOPTS="-j1" emake
}

src_install() {
	MAKEOPTS="-j1" DESTDIR="${D}" emake install
	docinto examples
	dodoc -r "${ED}"/usr/share/doc/${PN}/example/*
	docinto html/tools-dev
	dodoc -r "${ED}"/usr/share/doc/${PF}/tools-dev/html/*
	java-pkg_dojar "${ED}/usr/share/java/CubeReader.jar"

	rm -r "${ED}/usr/share/doc/${PF}/tools-dev" || die
	rm -r "${ED}/usr/share/doc/${PN}" || die
	rm -r "${ED}/usr/share/java/CubeReader.jar" || die
}
