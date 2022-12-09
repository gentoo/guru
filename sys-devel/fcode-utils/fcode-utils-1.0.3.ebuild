# Copyright 2022 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Set of utilities to process FCODE, OpenFirmware's byte code"
HOMEPAGE="https://www.openfirmware.info/FCODE_suite"
SRC_URI="https://github.com/openbios/fcode-utils/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2 CPL-1.0"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( documentation/ )

src_prepare() {
	default
	sed -i 's;^STRIP\b.*;STRIP = true;' toke/Makefile detok/Makefile romheaders/Makefile || die
}
