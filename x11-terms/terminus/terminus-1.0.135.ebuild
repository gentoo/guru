# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A terminal for a more modern age"

HOMEPAGE="https://eugeny.github.io/terminus/"
SRC_URI="https://github.com/Eugeny/${PN}/releases/download/v${PV}/${P}-linux.tar.gz https://github.com/ScardracS/icons/releases/download/release/${PN}-icons.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

inherit desktop xdg

S=""${WORKDIR}"/"${P}"-linux"

DEPEND="net-print/cups" # Requested by electron

src_prepare(){
	default

	# Remove useless license files.
	rm LICENSE.electron.txt LICENSES.electron.html
}

src_install(){
	insinto /opt/"${PN}"
	doins -r "${S}"/*
	dosym "${EPREFIX}"/opt/"${PN}"/terminus "${EPREFIX}"/usr/bin/terminus
	fperms +x /opt/"${PN}"/terminus
	make_desktop_entry /opt/terminus/terminus terminus terminus Utility
	doicon ../terminus.svg
	doicon ../terminus.ico
	for i in {16,24,32,48,64,72,96,128,512}; do
		doicon -s "${i}" ../terminus-"${i}".png
	done
}
