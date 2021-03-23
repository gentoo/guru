# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A hackable text editor for the 21st Century"

HOMEPAGE="https://atom.io/"
SRC_URI="https://github.com/atom/atom/releases/download/v1.55.0/${PN}-amd64.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

inherit desktop

S="${WORKDIR}/${P}-amd64"

DEPEND="net-print/cups" # Requested by electron

src_prepare(){
	default

	# Remove useless license files.
	rm LICENSE.electron.txt LICENSES.electron.html
}

src_install(){
	insinto /opt/"${PN}"
	doins -r "${S}"/*
	dosym "${EPREFIX}"/opt/"${PN}"/atom "${EPREFIX}"/usr/bin/atom
	fperms +x /opt/"${PN}"/atom
	make_desktop_entry /opt/atom/atom Atom atom Utility
	doicon atom
}
