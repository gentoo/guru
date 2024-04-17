# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop java-utils-2 rpm xdg

DESCRIPTION="Spanish government's electronic signature application for online procedures"
HOMEPAGE="
	https://administracionelectronica.gob.es/ctt/clienteafirma
	https://github.com/ctt-gob-es/clienteafirma
"
# Upstream blocks wget, so we need a fallback option
SRC_URI="https://estaticos.redsara.es/comunes/autofirma/$(ver_rs 1- /)/AutoFirma_Linux_Fedora.zip -> ${P}.zip
	https://distfiles.chuso.net/distfiles/${P}.zip"

LICENSE="|| ( GPL-2 EUPL-1.1 )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="virtual/jre:1.8"
BDEPEND="app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	default
	rpm_unpack "./${P}-1.noarch_FEDORA.rpm"
}

src_install() {
	java-pkg_dojar "usr/lib64/${PN}/${PN}.jar"
	java-pkg_dolauncher
	java-pkg_dojar "usr/lib64/${PN}/${PN}Configurador.jar"
	doicon "usr/lib64/${PN}/${PN}.png"
	make_desktop_entry \
		"${PN} %u" AutoFirma "${PN}" "Utility" \
		"Comment[es]=Aplicación de firma electrónica de la FNMT\nMimeType=x-scheme-handler/afirma"
}
