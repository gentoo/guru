# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN%-bin}"

inherit desktop systemd

DESCRIPTION="Local platform for home banking"
HOMEPAGE="https://willuhn.de/"
SRC_URI="https://willuhn.de/products/jameica/releases/current/jameica/jameica-linux64-${PV}.zip"

S="${WORKDIR}/jameica"

# Jameica: GPL-2
# lib/apache_xmlrpc, lib/jakarta_commons, lib/velocity: Apache-2.0
# lib/swt: CPL-1.0 LGPL-2 MPL-1.1
# lib/h2: EPL-1.0 MPL-2.0
# lib/paperclips: EPL-1.0
# lib/mckoi, lib/mysql: GPL-2
# lib/de_willuhn_ds, lib/de_willuhn_util, lib/swtcalendar: LGPL-2
# lib/bouncycastle: MIT
# lib/nanoxml: ZLIB
LICENSE="Apache-2.0 CPL-1.0 EPL-1.0 GPL-2 LGPL-2 MIT MPL-1.1 MPL-2.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	virtual/jre
"
BDEPEND="
	app-arch/unzip
"

JAMEICA_INSFILES=( jameica-icon.png jameica{,-linux64}.jar lib plugin.xml )
JAMEICA_EXEFILES=( jameicaserver.sh jameica.sh rcjameica-systemd )

src_install() {
	dodoc README

	insinto /opt/${MY_PN}
	doins -r "${JAMEICA_INSFILES[@]}"
	exeinto /opt/${MY_PN}
	doexe "${JAMEICA_EXEFILES[@]}"

	systemd_dounit "${MY_PN}.service"

	# There is plenty of dirt, mainly in the bundled libs
	find "${ED}/opt/${MY_PN}" -type f \( \
			-name "LICENSE" \
			-o -name "license.txt" \
			-o -name "license.html" \
			-o -name "lgpl*.txt" \
			-o -name "mpl*.txt" \
			-o -name "webkit-bsd.txt" \
			-o -name "*README*" \
		\) -delete || die

	make_desktop_entry "/bin/sh /opt/${MY_PN}/jameica.sh" ${MY_PN}
}
