# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit desktop java-pkg-2

DESCRIPTION="A visualization platform for molecular interaction networks"
HOMEPAGE="http://www.cytoscape.org/"
SRC_URI="https://github.com/cytoscape/cytoscape/releases/download/${PV}/cytoscape-unix-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=virtual/jre-11-r2"

S="${WORKDIR}"

src_install() {
	MY_PN="cytoscape"
	MYW="${WORKDIR}/${MY_PN}-unix-${PV}"

	insinto "/opt/${MY_PN}"
	doins -r ${MYW}/apps
	doins -r ${MYW}/framework
	doins -r ${MYW}/sampleData

	cd ${MYW}
	sh gen_vmoptions.sh
	doins Cytoscape.vmoptions
	exeinto "/opt/${MY_PN}"
	doexe "${MYW}/${MY_PN}.sh"
	dosym "${EPREFIX}/opt/${MY_PN}/${MY_PN}.sh" "${EPREFIX}/opt/bin/${MY_PN}"

	exeinto "/opt/${MY_PN}/framework/bin"
	doexe framework/bin/karaf

	newicon framework/cytoscape_logo_512.png cytoscape_logo.png
	make_desktop_entry ${MY_PN} CytoScape cytoscape_logo Science
}
